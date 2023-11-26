import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/index.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'child.dart';
import 'el_type.dart';

abstract base class DUITElement<T> with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  final String id;
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

    final type = convert(json["type"]);
    final id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final tag = json["tag"];
    final attributes =
        ViewAttributeWrapper.createAttributes<T>(type, json["attributes"], tag);
    final ServerAction? serverAction =
        json["action"] != null ? ServerAction.fromJSON(json["action"]) : null;
    assert(id != null, "Id cannot be null");

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
                true,
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

  Widget renderView() {
    return getWidgetFromElement(this);
  }

//</editor-fold>
}

//<editor-fold desc="Inherited models">
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

final class RowUIElement<RowAttributes> extends DUITElement<RowAttributes>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DUITElement> children = const [];

  @override
  ViewAttributeWrapper<RowAttributes>? attributes;

  @override
  UIElementController<RowAttributes>? viewController;

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

final class SizedBoxUIElement<SizedBoxAttributes>
    extends DUITElement<SizedBoxAttributes> implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<SizedBoxAttributes>? attributes;

  @override
  UIElementController<SizedBoxAttributes>? viewController;

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

final class TextUIElement<TextAttributes> extends DUITElement<TextAttributes> {
  //<editor-fold desc="Properties and ctor">

  @override
  ViewAttributeWrapper<TextAttributes>? attributes;

  @override
  UIElementController<TextAttributes>? viewController;

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

final class TextFieldUIElement<TextFieldAttributes>
    extends DUITElement<TextFieldAttributes> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<TextFieldAttributes>? attributes;

  @override
  UIElementController<TextFieldAttributes>? viewController;

  TextFieldUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required this.attributes,
    required this.viewController,
  });
//</editor-fold>
}

final class EmptyUIElement<EmptyAttributes>
    extends DUITElement<EmptyAttributes> {
  @override
  ViewAttributeWrapper<EmptyAttributes>? attributes;

  @override
  UIElementController<EmptyAttributes>? viewController;

  EmptyUIElement({
    super.type = DUITElementType.empty,
    super.id = "",
  });
}
//</editor-fold>
