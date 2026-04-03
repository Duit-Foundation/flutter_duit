import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/ui/element_property_view.dart";
import "package:flutter_duit/src/ui/element_type.dart";
import "package:flutter_duit/src/utils/index.dart";

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

  /// Wraps an [ElementPropertyView] in a [DuitElement].
  ///
  /// It`s needs to use elemets as part of DuitElement tree as independent widget.
  factory DuitElement.wrap(ElementPropertyView element) => DuitElement._(element);

  @override
  UIElementController get viewController => _element.viewController;

  @override
  ViewAttribute get attributes => _element.attributes;

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
  /// The method handles child relationships per [ElementChildRelation]:
  /// - **single**: Processes a single child element
  /// - **multi**: Processes a list of child elements
  /// - **component**: Processes a component with associated data that gets
  ///   merged with the component's model
  ///
  /// **Important Design Pattern Note:**
  ///
  /// The recursive calls to `DuitElement.fromJson()` for [ElementChildRelation.single]
  /// and [ElementChildRelation.multi] are made
  /// solely for their side effects. The returned `DuitElement` instances are
  /// intentionally ignored because:
  /// - `ElementPropertyView.fromJson()` already processes and stores child
  ///   relationships internally during the initial parsing
  /// - The JSON structure (`Map<String, dynamic>`) is modified in-place during
  ///   processing, establishing the parent-child relationships
  /// - No explicit parent-child linking is needed since the tree structure is
  ///   maintained through the internal state of `ElementPropertyView`
  /// - This approach avoids creating unnecessary object references and
  ///   simplifies memory management
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

    // Recursive processing of child elements (see method documentation for design pattern details)
    switch (_resolveChildRelation(element)) {
      case ElementChildRelation.single:
        final child = JsonUtils.extractMap(
          json,
          "child",
        );
        if (child != null) {
          DuitElement.fromJson(child, driver);
        }
        return DuitElement._(element);
      case ElementChildRelation.multi:
        final children = JsonUtils.extractList<Map<String, dynamic>?>(
          json,
          "children",
        );
        if (children.isNotEmpty) {
          for (final child in children) {
            //Safely handle null values at children list
            //It`s important for some cases eg. as Scaffold sub-widgets passing
            if (child != null) {
              DuitElement.fromJson(child, driver);
            }
          }
        }
        return DuitElement._(element);
      case ElementChildRelation.component:
        if (element.tag == null) {
          throw NullTagException(
            "Component tag is null \n json: $json",
          );
        }

        final providedData = JsonUtils.extractMap(json, "data") ?? <String, dynamic>{};

        final model = DuitRegistry.getComponentDescription(element.tag!);

        if (model != null) {
          final child = ComponentBuilder.build(
            model,
            providedData,
          );

          final childElement = DuitElement.fromJson(child, driver).element;
          element.componentChild = childElement;

          return DuitElement._(element);
        }
        return DuitElement._(element);
      case ElementChildRelation.fragment:
        if (element.tag == null) {
          throw NullTagException(
            "Fragment tag is null \n json: $json",
          );
        }

        final fragment = DuitRegistry.getFragment(element.tag!);

        if (fragment != null) {
          final processedFragment = DuitElement.fromJson(
            fragment,
            driver,
          );
          element.overwrite(
            processedFragment.element,
          );
        }
        return DuitElement._(element);
      default:
        return DuitElement._(element);
    }
  }

  static int _resolveChildRelation(ElementPropertyView element) {
    if (element.type == ElementType.external) {
      final name = element.externalTypeName;

      return DuitRegistry.getDescriptor(name!)!.childRelation;
    }

    return element.type.childRelation;
  }

  /// Returns the rendered Flutter [Widget] for this [DuitElement].
  ///
  /// This method delegates the rendering logic to the underlying [ElementPropertyView]
  /// or custom element implementation, producing the corresponding Flutter widget tree.
  ///
  /// The returned widget reflects the current state and configuration of this element,
  /// including all attributes, children, and any associated controllers.
  ///
  /// This method is typically called by the Duit framework to build the UI from the
  /// element tree, and should not be called directly unless you are implementing
  /// custom rendering logic.
  ///
  /// Returns:
  ///   The root [Widget] representing this [DuitElement] in the Flutter widget tree.
  ///
  /// Example:
  /// ```dart
  /// final element = DuitElement.fromJson(json, driver);
  /// final widget = element.renderView();
  /// ```
  @override
  Widget renderView() => _element.renderView(this);

  @override
  String toString() => _element.toString();

  @override
  bool get isControlled => _element.controlled;
}
