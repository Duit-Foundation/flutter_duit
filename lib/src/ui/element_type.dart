/// Defines the types of UI elements that can be rendered in the Duit framework.
///
/// This enum represents all supported Flutter widget types that can be created
/// from JSON configuration. Each element type has specific properties that
/// determine its behavior, rendering characteristics, and child relationship patterns.
///
/// The enum provides a mapping between string identifiers (used in JSON) and
/// the corresponding element types, enabling dynamic widget creation based on
/// configuration data.
///
/// Element types are categorized by their child relationship patterns:
/// - **No children (0)**: Leaf widgets like Text, Image, TextField
/// - **Single child (1)**: Wrapper widgets like Container, Padding, Center
/// - **Multiple children (2)**: Layout widgets like Row, Column, Stack
/// - **Component content (3)**: Special case for component-based elements
/// - **Fragment content (4)**: Special case for fragment-based elements
///
/// Some elements are controlled by default, meaning they have built-in state
/// management capabilities and can respond to user interactions or programmatic updates.
enum ElementType {
  row(
    name: "Row",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  column(
    name: "Column",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  stack(
    name: "Stack",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  expanded(
    name: "Expanded",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sizedBox(
    name: "SizedBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  text(
    name: "Text",
    isControlledByDefault: false,
    childRelation: 0,
  ),
  image(
    name: "Image",
    isControlledByDefault: false,
    childRelation: 0,
  ),
  container(
    name: "Container",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  gestureDetector(
    name: "GestureDetector",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  custom(
    name: "Custom",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  coloredBox(
    name: "ColoredBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  textField(
    name: "TextField",
    isControlledByDefault: true,
    childRelation: 0,
    mayHaveRelatedAction: true,
  ),
  padding(
    name: "Padding",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  checkbox(
    name: "CheckBox",
    isControlledByDefault: true,
    childRelation: 0,
    mayHaveRelatedAction: true,
  ),
  decoratedBox(
    name: "DecoratedBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  center(
    name: "Center",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  elevatedButton(
    name: "ElevatedButton",
    isControlledByDefault: true,
    childRelation: 1,
    mayHaveRelatedAction: true,
  ),
  positioned(
    name: "Positioned",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  align(
    name: "Align",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  transform(
    name: "Transform",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  richText(
    name: "RichText",
    isControlledByDefault: false,
    childRelation: 0,
  ),
  wrap(
    name: "Wrap",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  lifecycleStateListener(
    name: "LifecycleStateListener",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  component(
    name: "Component",
    isControlledByDefault: true,
    childRelation: 3,
  ),
  singleChildScrollview(
    name: "SingleChildScrollView",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  radio(
    name: "Radio",
    isControlledByDefault: false,
    childRelation: 0,
  ),
  radioGroupContext(
    name: "RadioGroupContext",
    isControlledByDefault: true,
    childRelation: 1,
    mayHaveRelatedAction: true,
  ),
  ignorePointer(
    name: "IgnorePointer",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  opacity(
    name: "Opacity",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  slider(
    name: "Slider",
    isControlledByDefault: true,
    childRelation: 1,
    mayHaveRelatedAction: true,
  ),
  fittedBox(
    name: "FittedBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  switch_(
    name: "Switch",
    isControlledByDefault: true,
    childRelation: 0,
    mayHaveRelatedAction: true,
  ),
  subtree(
    name: "Subtree",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  meta(
    name: "Meta",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  listView(
    name: "ListView",
    isControlledByDefault: false,
    childRelation: 2,
    mayHaveRelatedAction: true,
  ),
  repaintBoundary(
    name: "RepaintBoundary",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  overflowBox(
    name: "OverflowBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  animatedSize(
    name: "AnimatedSize",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  intrinsicHeight(
    name: "IntrinsicHeight",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  intrinsicWidth(
    name: "IntrinsicWidth",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  rotatedBox(
    name: "RotatedBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  constrainedBox(
    name: "ConstrainedBox",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  backdropFilter(
    name: "BackdropFilter",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  animatedOpacity(
    name: "AnimatedOpacity",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  remoteSubtree(
    name: "RemoteSubtree",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  safeArea(
    name: "SafeArea",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  gridView(
    name: "GridView",
    isControlledByDefault: false,
    childRelation: 2,
    mayHaveRelatedAction: true,
  ),
  card(
    name: "Card",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  appBar(
    name: "AppBar",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  scaffold(
    name: "Scaffold",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  inkWell(
    name: "InkWell",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  carouselView(
    name: "CarouselView",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  animatedContainer(
    name: "AnimatedContainer",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedAlign(
    name: "AnimatedAlign",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedRotation(
    name: "AnimatedRotation",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedPadding(
    name: "AnimatedPadding",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedPositioned(
    name: "AnimatedPositioned",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedScale(
    name: "AnimatedScale",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  flexibleSpaceBar(
    name: "FlexibleSpaceBar",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  sliverPadding(
    name: "SliverPadding",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  customScrollView(
    name: "CustomScrollView",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  sliverFillRemaining(
    name: "SliverFillRemaining",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverToBoxAdapter(
    name: "SliverToBoxAdapter",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverFillViewport(
    name: "SliverFillViewport",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  sliverOpacity(
    name: "SliverOpacity",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverVisibility(
    name: "SliverVisibility",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  sliverAnimatedOpacity(
    name: "SliverAnimatedOpacity",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  sliverOffstage(
    name: "SliverOffstage",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverIgnorePointer(
    name: "SliverIgnorePointer",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverSafeArea(
    name: "SliverSafeArea",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  sliverList(
    name: "SliverList",
    isControlledByDefault: false,
    childRelation: 2,
    mayHaveRelatedAction: true,
  ),
  sliverAppBar(
    name: "SliverAppBar",
    isControlledByDefault: false,
    childRelation: 2,
  ),
  sliverGrid(
    name: "SliverGrid",
    isControlledByDefault: false,
    childRelation: 2,
    mayHaveRelatedAction: true,
  ),
  absorbPointer(
    name: "AbsorbPointer",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  offstage(
    name: "Offstage",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  animatedCrossFade(
    name: "AnimatedCrossFade",
    isControlledByDefault: true,
    childRelation: 2,
  ),
  physicalModel(
    name: "PhysicalModel",
    isControlledByDefault: false,
    childRelation: 1,
  ),
  animatedPhysicalModel(
    name: "AnimatedPhysicalModel",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedBuilder(
    name: "AnimatedBuilder",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  animatedSlide(
    name: "AnimatedSlide",
    isControlledByDefault: true,
    childRelation: 1,
  ),
  fragment(
    name: "Fragment",
    isControlledByDefault: false,
    childRelation: 4,
  );

  /// The string identifier name of the UI element type.
  ///
  /// This corresponds to the Flutter widget class name that will be rendered.
  /// For example: "Row", "Column", "Container", etc.
  final String name;

  /// Whether this element type is controlled by default.
  ///
  /// Controlled elements typically have state management capabilities
  /// and can respond to user interactions or programmatic updates.
  /// Examples of controlled elements include TextField, CheckBox, ElevatedButton.
  final bool isControlledByDefault;

  /// Defines the child relationship pattern for this element type.
  ///
  /// - `0`: No child elements (leaf widgets like Text, Image)
  /// - `1`: Single child element (wrapper widgets like Container, Padding)
  /// - `2`: Multiple child elements (layout widgets like Row, Column, Stack)
  /// - `3`: Component content
  /// - `4`: Fragment content
  final int childRelation;

  // Determines whether a widget of this type can have an associated action (which is passed in the widget model, not through attributes)
  final bool mayHaveRelatedAction;

  const ElementType({
    required this.name,
    required this.isControlledByDefault,
    required this.childRelation,
    this.mayHaveRelatedAction = false,
  });

  /// Converts a string name to the corresponding [ElementType].
  ///
  /// This method performs a lookup in the internal mapping table to find
  /// the element type that matches the provided string name.
  ///
  /// Parameters:
  /// - [name]: The string identifier of the element type
  ///
  /// Returns the corresponding [ElementType] instance.
  ///
  /// Throws an [ArgumentError] if the name is not recognized.
  ///
  /// Example:
  /// ```dart
  /// final elementType = ElementType.value("Row");
  /// // Returns ElementType.row
  /// ```
  static ElementType value(String name) =>
      _stringToTypeLookupTable[name] ??
      (throw ArgumentError(
        "Unknown element type: $name",
      ));

  /// Converts a string name to the corresponding [ElementType], or returns null.
  ///
  /// This method performs a lookup in the internal mapping table to find
  /// the element type that matches the provided string name. Unlike [value],
  /// this method returns null instead of throwing an exception if the name
  /// is not recognized.
  ///
  /// Parameters:
  /// - [name]: The string identifier of the element type
  ///
  /// Returns the corresponding [ElementType] instance, or null if not found.
  ///
  /// Example:
  /// ```dart
  /// final elementType = ElementType.valueOrNull("Row");
  /// // Returns ElementType.row
  ///
  /// final unknownType = ElementType.valueOrNull("UnknownWidget");
  /// // Returns null
  /// ```
  static ElementType? valueOrNull(String name) =>
      _stringToTypeLookupTable[name];
}

const _stringToTypeLookupTable = <String, ElementType>{
  "Row": ElementType.row,
  "Column": ElementType.column,
  "Stack": ElementType.stack,
  "Expanded": ElementType.expanded,
  "SizedBox": ElementType.sizedBox,
  "Text": ElementType.text,
  "Image": ElementType.image,
  "Container": ElementType.container,
  "GestureDetector": ElementType.gestureDetector,
  "Custom": ElementType.custom,
  "ColoredBox": ElementType.coloredBox,
  "TextField": ElementType.textField,
  "Padding": ElementType.padding,
  "CheckBox": ElementType.checkbox,
  "DecoratedBox": ElementType.decoratedBox,
  "Center": ElementType.center,
  "ElevatedButton": ElementType.elevatedButton,
  "Positioned": ElementType.positioned,
  "Align": ElementType.align,
  "Transform": ElementType.transform,
  "RichText": ElementType.richText,
  "Wrap": ElementType.wrap,
  "LifecycleStateListener": ElementType.lifecycleStateListener,
  "Component": ElementType.component,
  "SingleChildScrollView": ElementType.singleChildScrollview,
  "Radio": ElementType.radio,
  "RadioGroupContext": ElementType.radioGroupContext,
  "IgnorePointer": ElementType.ignorePointer,
  "Opacity": ElementType.opacity,
  "Slider": ElementType.slider,
  "FittedBox": ElementType.fittedBox,
  "Switch": ElementType.switch_,
  "Subtree": ElementType.subtree,
  "Meta": ElementType.meta,
  "ListView": ElementType.listView,
  "RepaintBoundary": ElementType.repaintBoundary,
  "OverflowBox": ElementType.overflowBox,
  "AnimatedSize": ElementType.animatedSize,
  "IntrinsicHeight": ElementType.intrinsicHeight,
  "IntrinsicWidth": ElementType.intrinsicWidth,
  "RotatedBox": ElementType.rotatedBox,
  "ConstrainedBox": ElementType.constrainedBox,
  "BackdropFilter": ElementType.backdropFilter,
  "AnimatedOpacity": ElementType.animatedOpacity,
  "RemoteSubtree": ElementType.remoteSubtree,
  "SafeArea": ElementType.safeArea,
  "GridView": ElementType.gridView,
  "Card": ElementType.card,
  "AppBar": ElementType.appBar,
  "Scaffold": ElementType.scaffold,
  "InkWell": ElementType.inkWell,
  "CarouselView": ElementType.carouselView,
  "AnimatedContainer": ElementType.animatedContainer,
  "AnimatedAlign": ElementType.animatedAlign,
  "AnimatedRotation": ElementType.animatedRotation,
  "AnimatedPadding": ElementType.animatedPadding,
  "AnimatedPositioned": ElementType.animatedPositioned,
  "AnimatedScale": ElementType.animatedScale,
  "FlexibleSpaceBar": ElementType.flexibleSpaceBar,
  "SliverPadding": ElementType.sliverPadding,
  "CustomScrollView": ElementType.customScrollView,
  "SliverFillRemaining": ElementType.sliverFillRemaining,
  "SliverToBoxAdapter": ElementType.sliverToBoxAdapter,
  "SliverFillViewport": ElementType.sliverFillViewport,
  "SliverOpacity": ElementType.sliverOpacity,
  "SliverVisibility": ElementType.sliverVisibility,
  "SliverAnimatedOpacity": ElementType.sliverAnimatedOpacity,
  "SliverOffstage": ElementType.sliverOffstage,
  "SliverIgnorePointer": ElementType.sliverIgnorePointer,
  "SliverSafeArea": ElementType.sliverSafeArea,
  "SliverList": ElementType.sliverList,
  "SliverAppBar": ElementType.sliverAppBar,
  "SliverGrid": ElementType.sliverGrid,
  "AbsorbPointer": ElementType.absorbPointer,
  "Offstage": ElementType.offstage,
  "AnimatedCrossFade": ElementType.animatedCrossFade,
  "PhysicalModel": ElementType.physicalModel,
  "AnimatedPhysicalModel": ElementType.animatedPhysicalModel,
  "AnimatedSlide": ElementType.animatedSlide,
  "AnimatedBuilder": ElementType.animatedBuilder,
  "Fragment": ElementType.fragment,
};
