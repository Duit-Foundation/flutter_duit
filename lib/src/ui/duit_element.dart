import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/element_property_view.dart';
import 'package:flutter_duit/src/ui/element_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A Duit element that represents a UI component in the element tree.
///
/// This class serves as a wrapper around [ElementPropertyView] and provides
/// access to the element's properties and rendering capabilities. It extends
/// [ElementTreeEntry] to participate in the element tree structure.
///
/// The class handles the creation of elements from JSON data and manages
/// the recursive processing of child elements based on their relationship types.
final class DuitElement extends ElementTreeEntry {
  final ElementPropertyView _element;

  /// Creates a new [DuitElement] with the given [ElementPropertyView].
  ///
  /// This constructor is private and should not be used directly.
  /// Use [DuitElement.fromJson] to create instances.
  DuitElement._(this._element);

  @override
  UIElementController get viewController => _element["controller"];

  @override
  ViewAttribute get attributes => _element["attributes"];

  @override
  List<ElementTreeEntry> get children => _element["children"];

  @override
  ElementTreeEntry? get child => _element["child"];

  /// Gets the type of this element.
  ///
  /// Returns the [ElementType] that defines the behavior and properties
  /// of this element.
  ElementType get type => _element.type;

  /// Gets the tag name of this element.
  ///
  /// Returns the tag string that identifies the type of component
  /// this element represents, or null if no tag is set.
  String? get tag => _element.tag;

  /// Gets the underlying [ElementPropertyView] instance.
  ///
  /// This provides direct access to the element's property view for
  /// advanced operations that require direct manipulation of the
  /// underlying data structure.
  @preferInline
  ElementPropertyView get element => _element;

  /// Creates a [DuitElement] from JSON data.
  ///
  /// This factory method parses the provided JSON data and creates a
  /// [DuitElement] instance with all its child elements recursively
  /// processed based on the element's child relationship type.
  ///
  /// The method handles three types of child relationships:
  /// - **Single child (case 1)**: Processes a single child element
  /// - **Multiple children (case 2)**: Processes a list of child elements
  /// - **Component with data (case 3)**: Processes a component with
  ///   associated data that gets merged with the component's model
  ///
  /// Parameters:
  /// - [json]: The JSON data representing the element and its children
  /// - [driver]: The UI driver instance for element creation
  ///
  /// Returns a new [DuitElement] instance with all child elements processed.
  factory DuitElement.fromJson(
    Map<String, dynamic> json,
    UIDriver driver,
  ) {
    final element = ElementPropertyView.fromJson(json, driver);

    //NOTE: This part of the method handles recursive processing of child elements
    //
    // IMPORTANT: The recursive calls to DuitElement.fromJson() are made for their side effects only.
    // The returned DuitElement instances are intentionally ignored because:
    // 1. ElementPropertyView.fromJson() already processes and stores child relationships internally
    // 2. The JSON structure (Map<String, dynamic>) is modified in-place during processing
    // 3. No explicit parent-child linking is needed since the tree structure is maintained
    //    through the internal state of ElementPropertyView
    //
    // This approach avoids creating unnecessary object references and simplifies memory management.
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
      case 3:
        final providedData = Map<String, dynamic>.from(json["data"]);

        final model = DuitRegistry.getComponentDescription(element.tag!);

        if (model != null) {
          final child = JsonUtils.mergeWithDataSource(
            model,
            providedData,
          );

          final childElement = DuitElement.fromJson(child, driver).element;
          element.componentChild = childElement;

          return DuitElement._(element);
        }

        return DuitElement._(element);

      default:
        return DuitElement._(element);
    }
  }

  @override
  Widget renderView() => _element.renderView(this);

  @override
  String toString() => _element.toString();
}
