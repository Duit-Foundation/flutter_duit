import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'child.dart';
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

  static Future<DuitElement> fromJson(JSONObject? json, UIDriver driver) async {
    if (json == null) return EmptyUIElement();

    final String type = json["type"];
    final String id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final String? tag = json["tag"];

    if (type == ElementType.component) {
      final providedData = json["data"] as Map<String, dynamic>;

      final model = DuitRegistry.getComponentDescription(tag!);

      if (model != null) {
        JsonUtils.mergeComponentLayoutDescriptionWithExternalData(
          model.data,
          providedData,
        );

        final controller = ViewController(
          id: id,
          driver: driver,
          type: type,
          tag: tag,
        );
        driver.attachController(id, controller);

        final child = await DuitElement.fromJson(model.data, driver);

        return ComponentUIElement(
          child: child,
          type: type,
          id: id,
          controlled: controlled,
          attributes: null,
          viewController: controller,
        );
      }

      return EmptyUIElement();
    }

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
      case ElementType.lifecycleStateListener:
        final child = await DuitElement.fromJson(json["child"], driver);

        //controlled - always false
        //ViewController necessary and created directly
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
      case ElementType.empty:
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

//<editor-fold desc="Inherited models">
final class SingleChildScrollviewUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SingleChildScrollviewUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class IgnorePointerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  IgnorePointerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class OpacityUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  OpacityUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class LifecycleStateListenerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  LifecycleStateListenerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class RadioGroupContextUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  RadioGroupContextUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class TransformUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  TransformUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class AlignUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AlignUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class GestureDetectorUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  GestureDetectorUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ContainerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ContainerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class DecoratedBoxUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  DecoratedBoxUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PositionedUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  PositionedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PaddingUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  PaddingUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class FittedBoxUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  FittedBoxUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ExpandedUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ExpandedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class StackUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  @override
  List<DuitElement> children = const [];

  StackUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
}

final class CustomDUITElement<T> extends DuitElement<T> {
  CustomDUITElement({
    required super.id,
  }) : super(type: ElementType.custom);
}

final class ElevatedButtonUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ElevatedButtonUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class CenterUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  CenterUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ColoredBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ColoredBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });
//</editor-fold>
}

final class ColumnUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children = const [];

  ColumnUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
//</editor-fold>
}

final class RowUIElement<T> extends DuitElement<T> implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children = const [];

  RowUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
//</editor-fold>
}

final class WrapUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children = const [];

  WrapUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
//</editor-fold>
}

final class SizedBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SizedBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });
//</editor-fold>
}

final class RichTextUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  RichTextUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class TextUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  TextUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class CheckboxUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  CheckboxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class RadioUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  RadioUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class SliderUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  SliderUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class TextFieldUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">
  TextFieldUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class ComponentUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ComponentUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class ImageUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  ImageUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class SwitchUiElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  SwitchUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class EmptyUIElement<T> extends DuitElement<T> {
  EmptyUIElement({
    super.type = ElementType.empty,
    super.id = "",
  });
}
//</editor-fold>
