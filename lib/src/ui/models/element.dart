import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/duit_impl/el.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
// import 'package:flutter_duit/src/ui/models/element_models.dart';
// import 'package:flutter_duit/src/ui/models/element_type.dart';
// import 'package:flutter_duit/src/ui/widgets/index.dart';
// import 'package:flutter_duit/src/utils/index.dart';

part 'lookup.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
base class DuitElement extends ElementTreeEntry {
  // //<editor-fold desc="Properties and ctor">
  // @override
  // ViewAttribute? attributes;

  // @override
  // UIElementController? viewController;

  DuitElement._(this._element);

  final NewDuitElement _element;

  @override
  UIElementController get viewController => _element["controller"];

  @override
  ViewAttribute get attributes => _element["attributes"];

  @override
  List<ElementTreeEntry> get children => _element["children"];

  @override
  ElementTreeEntry get child => _element["child"];

  // DuitElement({
  //   required super.type,
  //   required super.id,
  //   super.controlled = false,
  //   super.tag,
  //   this.viewController,
  //   this.attributes,
  // });

  static DuitElement fromJson(
    Map<String, dynamic> json,
    UIDriver driver,
  ) {
    final element = NewDuitElement.fromJson(json, driver);

    final lookupResult = _typeLookup[element.type];

    switch (lookupResult) {
      case 1:
        if (json.containsKey("child")) {
          final child = (json["child"] as Map<String, dynamic>);
          DuitElement.fromJson(child, driver);
        }
        return DuitElement._(element);
      case 2:
        if (json.containsKey("children")) {
          final children = (json["children"] as List<Map<String, dynamic>>);
          for (var child in children) {
            DuitElement.fromJson(child, driver);
          }
        }
        return DuitElement._(element);
      default:
        return DuitElement._(element);
    }
  }

  /// Renders the DUIT element to a Flutter widget.
  ///
  /// Returns the rendered Flutter widget.
  @override
  Widget renderView() => _element.renderView();

  @override
  String toString() => _element.toString();

//</editor-fold>
}
