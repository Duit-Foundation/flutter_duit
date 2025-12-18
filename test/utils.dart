// ignore_for_file: no_leading_underscores_for_local_identifiers

import "dart:async";
import "dart:math";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

double getFateTransitionOpacity(WidgetTester tester, Finder finder) {
  return tester
      .widget<FadeTransition>(
        find.ancestor(
          of: finder,
          matching: find.byType(FadeTransition),
        ),
      )
      .opacity
      .value;
}

double getOpacity(WidgetTester tester, Finder finder) {
  return tester
      .widget<Opacity>(
        find.ancestor(
          of: finder,
          matching: find.byType(Opacity),
        ),
      )
      .opacity;
}

String generateHexColor(int index) {
  final rng = Random(index);
  final randomNumber = rng.nextInt(0x1000000); // 0x1000000 == 16777216
  return '#${randomNumber.toRadixString(16).padLeft(6, '0')}';
}

final class MockTransport extends Transport {
  final Map<String, dynamic> mustReturnThis;

  MockTransport(
    super.url,
    this.mustReturnThis,
  );

  @override
  Future<Map<String, dynamic>?> connect({Map<String, dynamic>? initialData}) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  FutureOr<Map<String, dynamic>?> execute(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    return mustReturnThis;
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body, [
    Map<String, dynamic>? returnValue,
  ]) async {
    await Future.delayed(const Duration(seconds: 1));
    return mustReturnThis;
  }
}

extension TransportExtension on UIDriver {
  void applyMockTransport(mustReturnThis) {
    transport = MockTransport("", mustReturnThis);
  }
}

Future<void> pumpDriver(
  WidgetTester tester,
  UIDriver driver, [
  Key? key,
  SliverGridDelegatesRegistry? sliverGridDelegatesRegistry,
]) async {
  await tester.pumpWidget(
    MaterialApp(
      key: key,
      home: Material(
        child: DuitViewHost(
          driver: driver,
          sliverGridDelegatesRegistry: sliverGridDelegatesRegistry ?? const {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

// Mock UIDriver для тестирования
class MockUIDriver extends UIDriver {
  final List<String> evaluatedScripts = [];
  bool shouldThrowError = false;

  @override
  String get source => "mock_source";

  @override
  TransportOptions get transportOptions => EmptyTransportOptions();

  @override
  Transport? transport;

  @override
  BuildContext get buildContext => throw UnimplementedError();

  StreamController<ElementTree?> get streamController =>
      throw UnimplementedError();

  StreamController<UIDriverEvent> get eventStreamController =>
      throw UnimplementedError();

  @override
  ScriptRunner? scriptRunner;

  @override
  EventResolver get eventResolver => throw UnimplementedError();

  @override
  ActionExecutor get actionExecutor => throw UnimplementedError();

  @override
  ExternalEventHandler? externalEventHandler;

  @override
  MethodChannel? driverChannel;

  @override
  bool get isModule => false;

  @override
  DebugLogger? get logger => DefaultLogger.instance;

  @override
  void attachController(String id, UIElementController controller) {}

  @override
  void detachController(String id) {}

  @override
  UIElementController? getController(String id) => null;

  @override
  void dispose() {}

  @override
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) =>
      {};

  @override
  Future<ServerEvent?> execute(ServerAction action) async {
    if (shouldThrowError) {
      throw Exception("Mock execution error");
    }
    return null;
  }

  @override
  late Stream<UIDriverEvent> eventStream;

  late Stream<ElementTree?> stream;

  @override
  set actionExecutor(ActionExecutor _actionExecutor) {}

  @override
  Widget? build() {
    throw UnimplementedError();
  }

  @override
  set buildContext(BuildContext _buildContext) {}

  @override
  // ignore: avoid_setters_without_getters
  set context(BuildContext value) {}

  @override
  Future<void> evalScript(String source) {
    if (shouldThrowError) {
      throw Exception("Mock eval error");
    }
    evaluatedScripts.add(source);
    return Future.value();
  }

  @override
  set eventResolver(EventResolver _eventResolver) {}

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  set isModule(bool _isModule) {}

  @override
  bool isWidgetReady(String viewTag) {
    throw UnimplementedError();
  }

  @override
  set logger(DebugLogger? _logger) {}

  @override
  void notifyWidgetDisplayStateChanged(String viewTag, int state) {}

  @override
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) {
    throw UnimplementedError();
  }

  set eventStreamController(
    StreamController<UIDriverEvent> _eventStreamController,
  ) {}

  set streamController(StreamController<ElementTree?> _streamController) {}

  @override
  void attachFocusNode(String nodeId, FocusNode node) {
    // TODO: implement attachNode
  }

  @override
  void detachFocusNode(String nodeId) {
    // TODO: implement detachNode
    throw UnimplementedError();
  }

  @override
  bool focusInDirection(String nodeId, TraversalDirection direction) {
    // TODO: implement focusInDirection
    throw UnimplementedError();
  }

  @override
  bool nextFocus(String nodeId) {
    // TODO: implement nextFocus
    throw UnimplementedError();
  }

  @override
  bool previousFocus(String nodeId) {
    // TODO: implement previousFocus
    throw UnimplementedError();
  }

  @override
  void requestFocus(String nodeId) {
    // TODO: implement requestFocus
  }

  @override
  void unfocus(String nodeId,
      {UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    // TODO: implement unfocus
  }

  @override
  FocusNode? getNode(Object? key) {
    // TODO: implement getNode
    throw UnimplementedError();
  }
}
