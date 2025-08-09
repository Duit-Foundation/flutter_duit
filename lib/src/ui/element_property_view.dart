import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart'
    show Widget, SizedBox, SliverToBoxAdapter;
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/index.dart';
import 'package:flutter_duit/src/ui/widgets/grid_constructor.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';
import 'package:meta/meta.dart';

part 'widget_from_element.dart';
part 'build_fn_lookup.dart';

/// A typed view over a map representing a Duit UI element.
///
/// [ElementPropertyView] provides a performant, typed interface for working with
/// Duit UI element data. It wraps a [Map<String, dynamic>] and provides safe
/// access to element properties with performance optimization through
/// `@preferInline` annotations.
///
/// This extension type serves as the primary interface for:
/// - Accessing element properties (id, type, attributes, etc.)
/// - Managing element controllers for stateful widgets
/// - Building Flutter widgets from Duit element definitions
/// - Navigating element hierarchies (parent-child relationships)
///
/// ## Usage
///
/// ```dart
/// final jsonData = {
///   "type": "Text",
///   "id": "myText",
///   "controlled": true,
///   "attributes": {"data": "Hello World"}
/// };
///
/// final element = ElementPropertyView.fromJson(jsonData, uiDriver);
/// final widget = element.renderView(duitElement);
/// ```
extension type ElementPropertyView._(Map<String, dynamic> json) {
  /// Gets the attributes of this UI element.
  ///
  /// Returns a [ViewAttribute] object containing styling and behavioral
  /// properties for the widget. The attributes are lazily created and cached
  /// for performance.
  ///
  /// Example:
  /// ```dart
  /// final attrs = element.attributes;
  /// final textStyle = attrs.payload.textStyle();
  /// ```
  @preferInline
  ViewAttribute get attributes => json["_attributes"];

  /// Gets the controller for this UI element.
  ///
  /// Returns a [UIElementController] that manages the state and behavior
  /// of controlled widgets. Only available for elements where [controlled]
  /// returns `true`.
  ///
  /// Example:
  /// ```dart
  /// if (element.controlled) {
  ///   final controller = element.viewController;
  ///   controller.updateState({"newValue": 42});
  /// }
  /// ```
  @preferInline
  UIElementController get viewController => json["controller"];

  /// Whether this element is controlled (stateful) or uncontrolled (stateless).
  ///
  /// Controlled elements have a [UIElementController] that manages their state
  /// and can respond to user interactions or external updates. Uncontrolled
  /// elements are static and render based only on their initial attributes.
  ///
  /// Returns `false` if the "controlled" key is not present in the JSON.
  ///
  /// Example:
  /// ```dart
  /// final widget = element.controlled
  ///   ? DuitControlledText(controller: element.viewController)
  ///   : DuitText(attributes: element.attributes);
  /// ```
  @preferInline
  bool get controlled => json["controlled"] ?? false;

  /// Gets the unique identifier of this UI element.
  ///
  /// The ID is used to identify elements within the UI tree and is required
  /// for controlled elements to register their controllers with the UI driver.
  ///
  /// Example:
  /// ```dart
  /// print("Element ID: ${element.id}");
  /// final controller = driver.getController(element.id);
  /// ```
  @preferInline
  String get id => json["id"];

  /// Gets the type of this UI element.
  ///
  /// The type determines which Flutter widget will be created and corresponds
  /// to values defined in [ElementType]. Common types include "Text",
  /// "Container", "Row", "Column", etc.
  ///
  /// Example:
  /// ```dart
  /// switch (element.type) {
  ///   case ElementType.text:
  ///     return _buildText(element);
  ///   case ElementType.container:
  ///     return _buildContainer(element);
  /// }
  /// ```
  @preferInline
  ElementType get type {
    final type = json["type"];
    if (type is ElementType) {
      return type;
    }
    return json["type"] = ElementType.value(type);
  }

  /// Gets the optional tag of this UI element.
  ///
  /// Tags are used primarily for custom widgets to provide additional
  /// identification beyond the standard type system. Returns `null` if
  /// no tag is specified.
  ///
  /// Example:
  /// ```dart
  /// if (element.tag != null) {
  ///   final customBuilder = DuitRegistry.getBuildFactory(element.tag!);
  ///   return customBuilder?.call(element, children);
  /// }
  /// ```
  @preferInline
  String? get tag => json["tag"];

  /// Direct access operator for the underlying JSON data.
  ///
  /// Provides access to any property in the element's JSON representation,
  /// including custom properties not covered by the typed getters.
  ///
  /// Example:
  /// ```dart
  /// final customProperty = element["customProperty"];
  /// final nestedData = element["nested"]["property"];
  /// ```
  @preferInline
  operator [](String key) => json[key];

  /// Checks if the element contains the specified key.
  ///
  /// Returns `true` if the key exists in the element's JSON data,
  /// `false` otherwise. Useful for checking optional properties.
  ///
  /// Example:
  /// ```dart
  /// if (element.containsKey("customProperty")) {
  ///   final value = element["customProperty"];
  ///   // Process custom property
  /// }
  /// ```
  @preferInline
  bool containsKey(String key) => json.containsKey(key);

  /// Gets the child elements of this UI element.
  ///
  /// Returns a list of [ElementPropertyView] objects representing the
  /// children of multi-child container widgets (like Row, Column, Stack).
  /// Returns an empty list if no children are present.
  ///
  /// Example:
  /// ```dart
  /// final widgets = element.children
  ///     .map((child) => _buildWidget(child))
  ///     .toList();
  /// ```
  @preferInline
  List<ElementPropertyView> get children =>
      JsonUtils.extractList<ElementPropertyView>(
        json,
        "children",
      );

  /// Gets the single child element of this UI element.
  ///
  /// Returns an [ElementPropertyView] for single-child container widgets
  /// (like Container, Center, Padding). Returns `null` if no child is present.
  ///
  /// Example:
  /// ```dart
  /// final childWidget = element.child != null
  ///     ? _buildWidget(element.child!)
  ///     : const SizedBox.shrink();
  /// ```
  @preferInline
  ElementPropertyView? get child => json["child"];

  @internal
  @preferInline
  set componentChild(ElementPropertyView child) => json["child"] = child;

  @preferInline
  void overwrite(ElementPropertyView other) => json.addAll(other.json);

  @preferInline
  ViewAttribute _createAttributes() {
    final attributes = json["attributes"] ?? <String, dynamic>{};
    return json["_attributes"] = ViewAttribute.from(
      type.name,
      attributes,
      id,
      tag: tag,
    );
  }

  @preferInline
  UIElementController _createViewController(UIDriver driver) {
    final controller = json["controller"];
    if (controller is UIElementController) {
      return controller;
    }

    final attributes = json["attributes"] ?? <String, dynamic>{};
    final attrs = ViewAttribute.from(
      type.name,
      attributes,
      id,
      tag: tag,
    );

    return json["controller"] = ViewController(
      id: id,
      driver: driver,
      type: type.name,
      action: DuitDataSource(json).getAction("action"),
      attributes: attrs,
      tag: tag,
    );
  }

  void _processElement(
    Map<String, dynamic> data,
    UIDriver driver,
  ) {
    final element = ElementPropertyView._(data);

    if (element.controlled || element.type.isControlledByDefault) {
      final id = element.id;
      final controller = element._createViewController(driver);

      driver.attachController(id, controller);
    } else {
      element._createAttributes();
    }
  }

  /// Creates an [ElementPropertyView] from JSON data and a UI driver.
  ///
  /// This is the primary factory constructor for creating DUIT elements from
  /// server responses or local JSON data. It performs the following operations:
  ///
  /// 1. Creates the [ElementPropertyView] wrapper
  /// 2. Processes the element data (creates attributes/controllers as needed)
  /// 3. Registers controlled elements with the provided [UIDriver]
  ///
  /// The [data] parameter should contain the element definition with at minimum
  /// "type" and "id" fields. The [driver] is used for registering controllers
  /// and handling element interactions.
  ///
  /// Example:
  /// ```dart
  /// final jsonData = {
  ///   "type": "Text",
  ///   "id": "greeting",
  ///   "controlled": true,
  ///   "attributes": {
  ///     "data": "Hello, World!",
  ///     "style": {"fontSize": 16}
  ///   }
  /// };
  ///
  /// final element = ElementPropertyView.fromJson(jsonData, uiDriver);
  /// ```
  ///
  /// Throws:
  /// - [ArgumentError] if required fields are missing from [data]
  /// - [StateError] if the driver is not properly initialized
  factory ElementPropertyView.fromJson(
    Map<String, dynamic> data,
    UIDriver driver,
  ) =>
      ElementPropertyView._(
        data,
      ).._processElement(
          data,
          driver,
        );

  /// Renders this element as a Flutter [Widget].
  ///
  /// This method is the primary entry point for converting DUIT elements
  /// into Flutter widgets. It uses the DUIT widget building system to
  /// determine the appropriate widget constructor based on the element's
  /// [type] and whether it's [controlled].
  ///
  /// The rendering process:
  /// 1. Looks up the build function for the element type
  /// 2. Calls the appropriate builder (controlled vs uncontrolled)
  /// 3. Recursively builds child widgets if present
  /// 4. Returns the constructed Flutter widget
  ///
  /// The [element] parameter should be the [DuitElement] that wraps this
  /// [ElementPropertyView] for additional context during rendering.
  ///
  /// Example:
  /// ```dart
  /// final duitElement = DuitElement.fromJson(jsonData, uiDriver);
  /// final widget = duitElement.element.renderView(duitElement);
  /// return Scaffold(body: widget);
  /// ```
  ///
  /// Returns a [SizedBox.shrink] if no appropriate builder is found.
  Widget renderView(DuitElement element) => _buildWidget(element);
}
