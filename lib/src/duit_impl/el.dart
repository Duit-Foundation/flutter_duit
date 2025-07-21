import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart' show Widget, SizedBox;
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';

part 'type_lookup.dart';

extension type DuitElementModel._(Map<String, dynamic> json) {
  @preferInline
  ViewAttribute get attributes => json["attributes"];

  @preferInline
  UIElementController get viewController => json["controller"];

  @preferInline
  bool get controlled => json["controlled"] ?? false;

  @preferInline
  String get id => json["id"];

  @preferInline
  String get type => json["type"];

  @preferInline
  String? get tag => json["tag"];

  @preferInline
  operator []=(String key, dynamic value) => json[key] = value;

  @preferInline
  operator [](String key) => json[key];

  @preferInline
  List<DuitElementModel> get children => json["children"] ?? [];

  @preferInline
  DuitElementModel get child => json["child"];

  @preferInline
  ViewAttribute _createAttributes() {
    final attributes = json["attributes"];
    if (attributes is ViewAttribute) {
      return attributes;
    }
    return json["attributes"] = ViewAttribute.from(
      type,
      Map<String, dynamic>.from(attributes ?? {}),
      id,
      tag: tag,
    );
  }

  @preferInline
  UIElementController _createViewController([UIDriver? driver]) {
    final controller = json["controller"];
    if (controller is UIElementController) {
      return controller;
    }
    final attributes = _createAttributes();
    return json["controller"] = ViewController(
      id: id,
      driver: driver!,
      type: type,
      action: attributes.payload.getAction("action"),
      attributes: attributes,
    );
  }

  void _processElement(
    Map<String, dynamic> data,
    UIDriver driver,
  ) {
    final element = DuitElementModel._(data);
    final type = element.type;

    if (element.controlled) {
      final id = element.id;
      final controller = element._createViewController(driver);

      driver.attachController(id, controller);
    } else {
      element._createAttributes();
    }

    final lookupResult = _typeLookup[type];

    switch (lookupResult) {
      case 1:
        if (data.containsKey("child")) {
          _processElement(data, driver);
          break;
        }
        break;
      case 2:
        if (data.containsKey("children")) {
          final childrenData = (data["children"] as List);

          for (var element in childrenData) {
            _processElement(element, driver);
          }
          break;
        }
        break;
      default:
        break;
    }
  }

  factory DuitElementModel.fromJson(
    Map<String, dynamic> data,
    UIDriver driver,
  ) =>
      DuitElementModel._(
        data,
      ).._processElement(
          data,
          driver,
        );

  // Map<String, dynamic> extractJson() {
  //   final lookupResult = _typeLookup[type];

  //   switch (lookupResult) {
  //     case 1:
  //       if (json.containsKey("child")) {
  //         final child = json["child"] as DuitElementModel;
  //         child.extractJson();
  //       }
  //     case 2:
  //       if (json.containsKey("children")) {
  //         final children = (json["children"] as List<DuitElementModel>);
  //         for (var child in children) {
  //           child.extractJson();
  //         }
  //       }
  //       break;
  //   }

  //   json.remove("controller");

  //   return json;
  // }

  @preferInline
  Widget renderView() => _getWidgetFromElement(this);

  @preferInline
  Widget _getWidgetFromElement(DuitElementModel element) {
    switch (element.type) {
      case ElementType.text:
        return switch (element.controlled) {
          true => DuitControlledText(controller: element.viewController),
          false => DuitText(attributes: element.attributes),
        };
      case ElementType.row:
        final children = <Widget>[];
        for (var child in element.children) {
          children.add(
            _getWidgetFromElement(child),
          );
        }
        return switch (element.controlled) {
          true => DuitControlledRow(
              controller: element.viewController,
              children: children,
            ),
          false => DuitRow(
              attributes: element.attributes,
              children: children,
            ),
        };
      default:
        return const SizedBox.shrink();
    }
  }
}
