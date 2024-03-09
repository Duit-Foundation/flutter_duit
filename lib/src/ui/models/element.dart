import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element_models.dart';
import 'element_type.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
base class DuitElement<T> extends TreeElement<T> with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  DuitElement({
    required super.type,
    required super.id,
    super.controlled = false,
    super.tag,
    this.viewController,
    this.attributes,
  });

  static Future<DuitElement> fromJson(
    JSONObject? json,
    UIDriver driver,
  ) async {
    if (json == null) return EmptyUIElement();

    final String type = json["type"];
    final String id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final String? tag = json["tag"];

    final ViewAttributeWrapper attributes =
        ViewAttributeWrapper.createAttributes(
      type,
      json["attributes"],
      tag,
    );
    final ServerAction? serverAction = ServerAction.fromJSON(json["action"]);

    if (serverAction?.executionType == 2) {
      assert(serverAction?.script != null,
          "Script can't be null when executionType == 2");
      final script = serverAction?.script as DuitScript;
      driver.evalScript(script.sourceCode);
    }

    switch (type) {
      case ElementType.row:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            DuitElement.fromJson(element, driver)
                .then((value) => arr.add(value));
          });
        }

        final el = RowUIElement(
          type: type,
          id: id,
          children: arr,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );

        return el;
      case ElementType.column:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            DuitElement.fromJson(element, driver)
                .then((value) => arr.add(value));
          });
        }

        return ColumnUIElement(
          type: type,
          id: id,
          children: arr,
          attributes: attributes,
          controlled: controlled,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
        );
      case ElementType.center:
        final child = await DuitElement.fromJson(json["child"], driver);

        return CenterUIElement(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.fittedBox:
        final child = await DuitElement.fromJson(json["child"], driver);

        return FittedBoxUiElement(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.coloredBox:
        final child = await DuitElement.fromJson(json["child"], driver);

        return ColoredBoxUIElement(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.sizedBox:
        final child = await DuitElement.fromJson(json["child"], driver);

        return SizedBoxUIElement(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.richText:
        return RichTextUIElement(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
        );
      case ElementType.text:
        return TextUIElement(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
        );
      case ElementType.elevatedButton:
        final child = await DuitElement.fromJson(json["child"], driver);

        return ElevatedButtonUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: true,
        );
      case ElementType.textField:
        return TextFieldUIElement(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: true,
        );
      case ElementType.stack:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            DuitElement.fromJson(element, driver)
                .then((value) => arr.add(value));
          });
        }

        return StackUIElement(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
          children: arr,
        );
      case ElementType.wrap:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            DuitElement.fromJson(element, driver)
                .then((value) => arr.add(value));
          });
        }

        return WrapUIElement(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
          children: arr,
        );
      case ElementType.expanded:
        final child = await DuitElement.fromJson(json["child"], driver);

        return ExpandedUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.padding:
        final child = await DuitElement.fromJson(json["child"], driver);

        return PaddingUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.positioned:
        final child = await DuitElement.fromJson(json["child"], driver);

        return PositionedUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.decoratedBox:
        final child = await DuitElement.fromJson(json["child"], driver);

        return DecoratedBoxUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );

      case ElementType.checkbox:
        //controlled by default
        //extends AttendedModel
        return CheckboxUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: true,
        );
      case ElementType.image:
        return ImageUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.switchW:
        return SwitchUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.radio:
        return RadioUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.slider:
        return SliderUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.container:
        final child = await DuitElement.fromJson(json["child"], driver);

        return ContainerUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.subtree:
        final child = await DuitElement.fromJson(json["child"], driver);

        return SubtreeUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.gestureDetector:
        final child = await DuitElement.fromJson(json["child"], driver);

        return GestureDetectorUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.align:
        final child = await DuitElement.fromJson(json["child"], driver);

        return AlignUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.transform:
        final child = await DuitElement.fromJson(json["child"], driver);

        return TransformUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.radioGroupContext:
        final child = await DuitElement.fromJson(json["child"], driver);

        return RadioGroupContextUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.singleChildScrollview:
        final child = await DuitElement.fromJson(json["child"], driver);

        return SingleChildScrollviewUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.opacity:
        final child = await DuitElement.fromJson(json["child"], driver);

        return OpacityUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.ignorePointer:
        final child = await DuitElement.fromJson(json["child"], driver);

        return IgnorePointerUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.meta:
        final child = await DuitElement.fromJson(json["child"], driver);

        return MetaUiElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.lifecycleStateListener:
        final child = await DuitElement.fromJson(json["child"], driver);

        //[controlled] - always false
        //[ViewController] necessary and created directly
        return LifecycleStateListenerUiElement(
          type: type,
          id: id,
          attributes: null,
          viewController: ViewController(
            id: id,
            driver: driver,
            action: serverAction,
            attributes: attributes,
            type: type,
            tag: tag,
          ),
          child: child,
          controlled: false,
        );
      case ElementType.listView:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            DuitElement.fromJson(element, driver)
                .then((value) => arr.add(value));
          });
        }

        return ListViewUIElement(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          children: arr,
          controlled: controlled,
        );
      case ElementType.empty:
        return EmptyUIElement();
      case ElementType.component:
        final providedData = json["data"] as Map<String, dynamic>;

        final model = DuitRegistry.getComponentDescription(tag!);

        if (model != null) {
          Map<String, dynamic> childModel = JsonUtils.fillComponentProperties(
            model.data,
            providedData,
          );

          final child = await DuitElement.fromJson(childModel, driver);

          return ComponentUIElement(
            child: child,
            type: type,
            id: id,
            controlled: true,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              true,
              attributes,
              null,
              driver,
              type,
              tag,
            ),
          );
        }

        return EmptyUIElement();
      case ElementType.custom:
        if (tag != null) {
          final mapper = DuitRegistry.getModelMapper(tag);
          if (mapper != null) {
            final controller = _createAndAttachController(
              id,
              controlled,
              attributes,
              serverAction,
              driver,
              type,
              tag,
            );
            return mapper.call(
              id,
              controlled,
              attributes,
              controller,
            ) as DuitElement;
          }
        }
        return EmptyUIElement();
      default:
        throw ArgumentError(
          "Cant infer element type from json schema: $type with id= $id",
        );
    }
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  /// Creates and attaches a controller to a specific element in the DUIT element tree.
  ///
  /// The [_createAndAttachController] function is used to create and attach a controller to a specific element in the DUIT element tree.
  ///
  /// Returns the attached controller or null if the element is not controlled.
  static UIElementController<T>? _createAndAttachController<T>(
    String id,
    bool controlled,
    ViewAttributeWrapper<T>? attributes,
    ServerAction? action,
    UIDriver driver,
    String type,
    String? tag,
  ) {
    final controller = switch (controlled) {
      false => null,
      true => ViewController<T>(
          id: id,
          driver: driver,
          action: action,
          attributes: attributes,
          type: type,
          tag: tag,
        )
    };

    if (controller != null) {
      driver.attachController(id, controller);
    }

    return controller;
  }

  /// Renders the DUIT element to a Flutter widget.
  ///
  /// Returns the rendered Flutter widget.
  @override
  Widget renderView() {
    return getWidgetFromElement(this);
  }

//</editor-fold>
}
