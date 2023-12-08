import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/index.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'child.dart';
import 'el_type.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DUITElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DUITElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
abstract base class DUITElement<T> with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  final String id;

  /// The type of the DUIT element.
  final DUITElementType type;
  final bool controlled;
  final String? tag;
  abstract UIElementController<T>? viewController;
  abstract ViewAttributeWrapper<T>? attributes;

  DUITElement({
    required this.type,
    required this.id,
    this.controlled = false,
    this.tag,
  });

  factory DUITElement.fromJson(JSONObject? json, UIDriver driver) {
    if (json == null) return EmptyUIElement();

    final DUITElementType type = inferTypeFromValue(json["type"]);
    final String id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final String? tag = json["tag"];
    final ViewAttributeWrapper<T> attributes =
        ViewAttributeWrapper.createAttributes<T>(type, json["attributes"], tag);
    final ServerAction? serverAction =
        json["action"] != null ? ServerAction.fromJSON(json["action"]) : null;

    switch (type) {
      case DUITElementType.row:
        {
          List<DUITElement> arr = [];

          if (json["children"] != null) {
            json["children"].forEach((element) {
              final child = DUITElement.fromJson(element, driver);
              arr.add(child);
            });
          }

          return RowUIElement(
            type: type,
            id: id,
            children: arr,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.column:
        {
          List<DUITElement> arr = [];

          if (json["children"] != null) {
            json["children"].forEach((element) {
              final child = DUITElement.fromJson(element, driver);
              arr.add(child);
            });
          }

          return ColumnUIElement(
            type: type,
            id: id,
            children: arr,
            attributes: attributes,
            controlled: controlled,
            viewController: createAndAttachController(
              id,
              controlled,
              attributes,
              serverAction,
              driver,
              type,
              tag,
            ),
          );
        }
      case DUITElementType.center:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return CenterUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.coloredBox:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return ColoredBoxUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.sizedBox:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return SizedBoxUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.text:
        {
          return TextUIElement(
            type: type,
            id: id,
            viewController: createAndAttachController<T>(
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
        }
      case DUITElementType.elevatedButton:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return ElevatedButtonUIElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.textField:
        {
          return TextFieldUIElement(
            type: type,
            id: id,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.stack:
        {
          List<DUITElement> arr = [];

          if (json["children"] != null) {
            json["children"].forEach((element) {
              final child = DUITElement.fromJson(element, driver);
              arr.add(child);
            });
          }

          return StackUIElement(
            type: type,
            id: id,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.expanded:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return ExpandedUiElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.padding:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return PaddingUiElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.positioned:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return PositionedUiElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.decoratedBox:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return DecoratedBoxUiElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.checkbox:
        {
          //controlled by default
          //extends AttendedModel
          return CheckboxUIElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.image:
        {
          return ImageUIElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.container:
        {
          final child = DUITElement.fromJson(json["child"], driver);

          return ContainerUiElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: createAndAttachController(
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
        }
      case DUITElementType.empty:
        {
          return EmptyUIElement();
        }
      case DUITElementType.custom:
        {
          if (tag != null) {
            final mapper = DUITRegistry.getModelMapper(tag);
            if (mapper != null) {
              final controller = createAndAttachController(
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
              ) as DUITElement<T>;
            } else {
              return EmptyUIElement();
            }
          }
          return EmptyUIElement();
        }
      default:
        {
          throw ArgumentError(
            "Cant infer element type from json schema: $type with id= $id",
          );
        }
    }
  }

  //</editor-fold>

  //<editor-fold desc="Methods">

  /// Creates and attaches a controller to a specific element in the DUIT element tree.
  ///
  /// The [createAndAttachController] function is used to create and attach a controller to a specific element in the DUIT element tree.
  ///
  /// Returns the attached controller or null if the element is not controlled.
  static UIElementController<T>? createAndAttachController<T>(
      String id,
      bool controlled,
      ViewAttributeWrapper<T>? attributes,
      ServerAction? action,
      UIDriver driver,
      DUITElementType type,
      String? tag) {
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
  Widget renderView() {
    return getWidgetFromElement(this);
  }

//</editor-fold>
}

//<editor-fold desc="Inherited models">
final class ContainerUiElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ContainerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class DecoratedBoxUiElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  DecoratedBoxUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PositionedUiElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  PositionedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PaddingUiElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  PaddingUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ExpandedUiElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ExpandedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class StackUIElement<T> extends DUITElement<T>
    implements MultiChildLayout {
  @override
  List<DUITElement> children = const [];

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  StackUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.children,
  });
}

final class CustomDUITElement<T> extends DUITElement<T> {
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  CustomDUITElement({
    required super.id,
  }) : super(type: DUITElementType.custom);
}

final class ElevatedButtonUIElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ElevatedButtonUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class CenterUIElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  CenterUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ColoredBoxUIElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ColoredBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.attributes,
    required this.viewController,
    required this.child,
  });
//</editor-fold>
}

final class ColumnUIElement<T> extends DUITElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DUITElement> children = const [];

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ColumnUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.children,
  });
//</editor-fold>
}

final class RowUIElement<T> extends DUITElement<T> implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DUITElement> children = const [];

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  RowUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.children,
  });
//</editor-fold>
}

final class SizedBoxUIElement<T> extends DUITElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  SizedBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });
//</editor-fold>
}

final class TextUIElement<T> extends DUITElement<T> {
  //<editor-fold desc="Properties and ctor">

  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  TextUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.viewController,
    required this.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class CheckboxUIElement<T> extends DUITElement<T> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  CheckboxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.attributes,
    required this.viewController,
  });
//</editor-fold>
}

final class TextFieldUIElement<T> extends DUITElement<T> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  TextFieldUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.attributes,
    required this.viewController,
  });
//</editor-fold>
}

final class ImageUIElement<T> extends DUITElement<T> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  ImageUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.attributes,
    required this.viewController,
  });
//</editor-fold>
}

final class EmptyUIElement<T> extends DUITElement<T> {
  @override
  ViewAttributeWrapper<T>? attributes;

  @override
  UIElementController<T>? viewController;

  EmptyUIElement({
    super.type = DUITElementType.empty,
    super.id = "",
  });
}
//</editor-fold>
