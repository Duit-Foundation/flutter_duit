import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'child.dart';
import 'el_type.dart';

sealed class DUITElement<T> with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  final String id;
  final DUITElementType type;
  final bool uncontrolled;
  abstract UIElementController<T>? viewController;
  abstract ViewAttributeWrapper<T>? attributes;

  DUITElement({
    required this.type,
    required this.id,
    this.uncontrolled = true,
  });

  factory DUITElement.fromJson(JSONObject json, UIDriver driver) {
    final type = convert(json["type"]);
    final id = json["id"];
    final bool uncontrolled = json["uncontrolled"] ?? true;
    final attributes =
        ViewAttributeWrapper.createAttributes<T>(type, json["attributes"]);
    //TODO исправить!!!!
    final serverAction = ServerAction(event: '');
    assert(id != null, "Id and type cannot be null");
    // assert(attributes != null, "Attributes cannot be null");

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
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            uncontrolled: uncontrolled,
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
            uncontrolled: uncontrolled,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
          );
        }
      case DUITElementType.center:
        {
          assert(json["child"] != null, "Child of ColoredBox must not be null");
          final child = DUITElement.fromJson(json["child"], driver);

          return CenterUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.coloredBox:
        {
          assert(json["child"] != null, "Child of ColoredBox must not be null");
          final child = DUITElement.fromJson(json["child"], driver);

          return ColoredBoxUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.sizedBox:
        {
          assert(json["child"] != null, "Child of SizedBox must not be null");
          final child = DUITElement.fromJson(json["child"], driver);
          
          return SizedBoxUIElement(
            type: type,
            id: id,
            child: child,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.text:
        {
          return TextUIElement(
            type: type,
            id: id,
            viewController: _createAndAttachController<T>(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            attributes: attributes,
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.elevatedButton:
        {
          assert(json["child"] != null, "Child of SizedBox must not be null");
          assert(
              uncontrolled != false, "ElevatedButton must not be uncontrolled");
          final child = DUITElement.fromJson(json["child"], driver);

          return ElevatedButtonUIElement(
            type: type,
            id: id,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            child: child,
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.textField:
        {
          assert(uncontrolled != false, "TextField must not be uncontrolled");

          return TextFieldUIElement(
            type: type,
            id: id,
            viewController: _createAndAttachController(
              id,
              uncontrolled,
              attributes,
              serverAction,
              driver,
              type,
            ),
            attributes: attributes,
            uncontrolled: uncontrolled,
          );
        }
      case DUITElementType.empty:
        {
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
  static UIElementController<T>? _createAndAttachController<T>(
      String id,
      bool uncontrolled,
      ViewAttributeWrapper<T>? attributes,
      ServerAction? action,
      UIDriver driver,
      DUITElementType type) {
    final controller = switch (uncontrolled) {
      true => null,
      false => ViewController<T>(
          id: id,
          driver: driver,
          action: action,
          attributes: attributes,
          type: type,
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
final class ElevatedButtonUIElement<ElevatedButtonAttributes>
    extends DUITElement<ElevatedButtonAttributes> implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<ElevatedButtonAttributes>? attributes;

  @override
  UIElementController<ElevatedButtonAttributes>? viewController;

  ElevatedButtonUIElement({
    required super.type,
    required super.id,
    required super.uncontrolled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class CenterUIElement<CenterAttributes>
    extends DUITElement<CenterAttributes> implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<CenterAttributes>? attributes;

  @override
  UIElementController<CenterAttributes>? viewController;

  CenterUIElement({
    required super.type,
    required super.id,
    required super.uncontrolled,
    required this.viewController,
    required this.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ColoredBoxUIElement<ColoredBoxAttributes>
    extends DUITElement<ColoredBoxAttributes> implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DUITElement child;

  @override
  ViewAttributeWrapper<ColoredBoxAttributes>? attributes;

  @override
  UIElementController<ColoredBoxAttributes>? viewController;

  ColoredBoxUIElement({
    required super.type,
    required super.id,
    required super.uncontrolled,
    required this.attributes,
    required this.viewController,
    required this.child,
  });
//</editor-fold>
}

final class ColumnUIElement<ColumnAttributes>
    extends DUITElement<ColumnAttributes> implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DUITElement> children = const [];

  @override
  ViewAttributeWrapper<ColumnAttributes>? attributes;

  @override
  UIElementController<ColumnAttributes>? viewController;

  ColumnUIElement({
    required super.type,
    required super.id,
    required super.uncontrolled,
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
    required super.uncontrolled,
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
    required super.uncontrolled,
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
    required super.uncontrolled,
    required this.viewController,
    required this.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $uncontrolled}';
  }
//</editor-fold>
}

final class TextFieldUIElement<TextFieldAttrPayload>
    extends DUITElement<TextFieldAttrPayload> {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttributeWrapper<TextFieldAttrPayload>? attributes;

  @override
  UIElementController<TextFieldAttrPayload>? viewController;

  TextFieldUIElement({
    required super.type,
    required super.id,
    required super.uncontrolled,
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
