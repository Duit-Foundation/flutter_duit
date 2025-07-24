import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/element_property_view.dart';
import 'package:flutter_duit/src/ui/element_type.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
final class DuitElement extends ElementTreeEntry {
  final ElementPropertyView _element;

  DuitElement._(this._element);

  @override
  UIElementController get viewController => _element["controller"];

  @override
  ViewAttribute get attributes => _element["attributes"];

  @override
  List<ElementTreeEntry> get children => _element["children"];

  @override
  ElementTreeEntry? get child => _element["child"];

  ElementType get type => _element.type;

  String? get tag => _element.tag;

  @preferInline
  ElementPropertyView get element => _element;

  factory DuitElement.fromJson(
    Map<String, dynamic> json,
    UIDriver driver,
  ) {
    final element = ElementPropertyView.fromJson(json, driver);

    switch (element.type.childRelation) {
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
          return DuitElement._(element);
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
  Widget renderView() => _element.renderView(this);

  @override
  String toString() => _element.toString();
}
