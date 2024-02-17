import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/duit_impl/hooks.dart";
import "package:flutter_duit/src/transport/index.dart";
import "package:flutter_duit/src/ui/models/attended_model.dart";
import "package:flutter_duit/src/ui/models/element_type.dart";
import "package:flutter_duit/src/ui/models/ui_tree.dart";
import "package:flutter_duit/src/utils/index.dart";

import "event.dart";

final class DuitDriver with DriverHooks implements UIDriver {
  @override
  final String source;
  @override
  Transport? transport;
  @override
  TransportOptions transportOptions;
  @override
  StreamController<DuitAbstractTree?> streamController =
      StreamController.broadcast();
  @override
  late BuildContext buildContext;

  @override
  set context(BuildContext value) {
    buildContext = value;
  }

  DuitAbstractTree? _layout;

  Map<String, UIElementController> _viewControllers = {};

  @protected
  final ExternalEventHandler? eventHandler;

  @override
  DuitScriptRunner? scriptRunner;

  @override
  Stream<DuitAbstractTree?> get stream =>
      streamController.stream.asBroadcastStream();

  DuitDriver(
    this.source, {
    required this.transportOptions,
    this.eventHandler,
  });

  @override
  void attachController(String id, UIElementController controller) {
    final hasController = _viewControllers.containsKey(id);
    assert(!hasController,
        "ViewController with id already exists. You cannot attach controller to driver because it  contains element for id ($id)");

    _viewControllers[id] = controller;
  }

  /// Returns a transport based on the specified transport type.
  ///
  /// This method is used internally to create and return a transport object based
  /// on the specified [type]. It switches on the [type] parameter and returns an
  /// instance of the corresponding transport class.
  ///
  /// Parameters:
  /// - [type]: The transport type.
  ///
  /// Returns:
  /// - An instance of the transport class based on the specified [type].
  /// - If the [type] is not recognized, it returns an instance of [HttpTransport].
  Transport _getTransport(String type) {
    switch (type) {
      case TransportType.http:
        {
          return HttpTransport(
            source,
            options: transportOptions as HttpTransportOptions,
          );
        }
      case TransportType.ws:
        {
          return WSTransport(
            source,
            options: transportOptions as WebSocketTransportOptions,
          );
        }
      default:
        {
          return HttpTransport(
            source,
            options: transportOptions as HttpTransportOptions,
          );
        }
    }
  }

  /// Resolves a server event from a JSON object.
  ///
  /// This method takes a [json] object representing a server event and converts
  /// it into a [ServerEvent] object. If the [json] object is valid and represents
  /// a recognized server event type, it creates an instance of the corresponding
  /// event class and assigns it to the [event] variable.
  ///
  /// Parameters:
  /// - [json]: The JSON object representing a server event.
  ///
  /// Returns: A [Future] that completes with [void].
  FutureOr<void> _resolveEvent(JSONObject? json) async {
    final event = ServerEvent.fromJson(json, this);
    onEventReceived?.call(event);
    if (event != null) {
      switch (event.type) {
        case ServerEventType.update:
          final updEvent = event as UpdateEvent;
          updEvent.updates.forEach((key, value) {
            _updateAttributes(key, value);
          });
          break;
        case ServerEventType.layoutUpdate:
          final layoutUpdateEvent = event as LayoutUpdateEvent;
          final newLayout = await layoutUpdateEvent.layout?.parse();

          if (newLayout != null) {
            _layout = newLayout;
            streamController.sink.add(_layout);
          }

          break;
        case ServerEventType.navigation:
          assert(eventHandler != null, "NavigationResolver is not set");
          final navEvent = event as NavigationEvent;
          await eventHandler?.handleNavigation(
            buildContext,
            navEvent.path,
            navEvent.extra,
          );
          break;
        case ServerEventType.openUrl:
          assert(eventHandler != null, "NavigationResolver is not set");
          final urlEvent = event as OpenUrlEvent;
          await eventHandler?.handleOpenUrl(urlEvent.url);
          break;
        case ServerEventType.custom:
          final customEvent = event as CustomEvent;
          await eventHandler?.handleCustomEvent(
            buildContext,
            customEvent.key,
            customEvent.extra,
          );
          break;
        case ServerEventType.sequenced:
          final sequence = event as SequencedEventGroup;
          for (final entry in sequence.events) {
            await _resolveEvent(entry.event);
            await Future.delayed(entry.delay);
          }
          break;
        case ServerEventType.grouped:
          final group = event as CommonEventGroup;
          for (final entry in group.events) {
            _resolveEvent(entry.event);
          }
          break;
      }
    }

    onEventHandled?.call();
  }

  Map<String, dynamic> _preparePayload(List<ActionDependency> deps) {
    final Map<String, dynamic> payload = {};

    if (deps.isNotEmpty) {
      for (final dependency in deps) {
        final controller = _viewControllers[dependency.id];
        if (controller != null) {
          if (controller.attributes?.payload is AttendedModel) {
            final model = controller.attributes?.payload as AttendedModel;
            payload[dependency.target] = model.collect();
          }
        }
      }
    }

    return payload;
  }

  @override
  Future<void> init() async {
    onInit?.call();
    if (_layout != null) {
      await Future.delayed(Duration.zero);
      streamController.sink.add(_layout);
    } else {
      ViewAttributeWrapper.attributeParser = AttributeParser();
      transport ??= _getTransport(transportOptions.type);

      final json = await transport?.connect();
      assert(json != null);

      if (transport is Streamer) {
        final streamer = transport as Streamer;
        streamer.eventStream.listen(_resolveEvent);
      }

      _layout = DuitTree(json: json!, driver: this);
      streamController.sink.add(await _layout?.parse());
    }
  }

  @override
  Widget? build() {
    return _layout?.render();
  }

  @override
  Future<void> execute(ServerAction action) async {
    beforeActionCallback?.call(action);

    switch (action.executionType) {
      //transport
      case 0:
        {
          try {
            final payload = _preparePayload(action.dependsOn);

            final event = await transport?.execute(action, payload);
            //case with http request
            if (event != null) {
              await _resolveEvent(event);
            }
          } catch (e) {
            debugPrint(e.toString());
          }

          break;
        }
      //local execution
      case 1:
        {
          try {
            await _resolveEvent(action.payload);
          } catch (e) {
            debugPrint(e.toString());
          }
          break;
        }
      //script
      case 2:
        {
          try {
            final body = _preparePayload(action.dependsOn);
            assert(action.script != null,
                "Script can't be null when executionType == 2");
            final script = action.script as DuitScript;

            final scriptInvocationResult = await scriptRunner?.runScript(
              script.functionName,
              url: action.event,
              meta: action.payload,
              body: body,
            );
            _resolveEvent(scriptInvocationResult);
          } catch (e) {
            debugPrint(e.toString());
          }

          break;
        }
    }
  }

  @override
  void dispose() {
    onDispose?.call();
    transport?.dispose();
    _viewControllers = {};
    _layout = null;
    streamController.close();
  }

  /// Updates the attributes of a controller.
  ///
  /// This method is called to update the attributes of a controller based on the
  /// provided [json] object.
  ///
  /// Parameters:
  /// - [id]: The id of the controller.
  /// - [json]: The json object containing the updated attributes.
  void _updateAttributes(String id, JSONObject json) {
    final controller = _viewControllers[id];
    if (controller != null) {
      if (controller.type == ElementType.component) {
        final tag = controller.tag;
        final description = DuitRegistry.getComponentDescription(tag!);

        if (description != null) {
          JsonUtils.mergeComponentLayoutDescriptionWithExternalData(
            description.data,
            json,
          );

          final tree = DuitTree(
            json: description.data,
            driver: this,
          );

          final attributes = ViewAttributeWrapper.createAttributes(
            controller.type,
            {
              "tree": tree,
            },
            controller.tag,
          );

          controller.updateState(attributes);
        }
      }

      final attributes = ViewAttributeWrapper.createAttributes(
        controller.type,
        json,
        controller.tag,
      );
      controller.updateState(attributes);
    }
  }

  @override
  Future<void> evalScript(String source) async {
    await scriptRunner?.eval(source);
  }
}
