import "package:duit_kernel/duit_kernel.dart";

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
/// Element types are categorized by their child relationship patterns
/// ([ElementChildRelation] codes):
/// - **none (0)**: Leaf widgets like Text, Image, TextField
/// - **single (1)**: Wrapper widgets like Container, Padding, Center
/// - **multi (2)**: Layout widgets like Row, Column, Stack
/// - **component (3)**: Component-based elements
/// - **fragment (4)**: Fragment-based elements
///
/// Some elements are controlled by default, meaning they have built-in state
/// management capabilities and can respond to user interactions or programmatic updates.
enum ElementType {
  row(
    name: "Row",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  column(
    name: "Column",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  stack(
    name: "Stack",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  expanded(
    name: "Expanded",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  flexible(
    name: "Flexible",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sizedBox(
    name: "SizedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  text(
    name: "Text",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  image(
    name: "Image",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  icon(
    name: "Icon",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  container(
    name: "Container",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  gestureDetector(
    name: "GestureDetector",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  custom(
    name: "Custom",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  coloredBox(
    name: "ColoredBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  textField(
    name: "TextField",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.none,
    mayHaveRelatedAction: true,
  ),
  padding(
    name: "Padding",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  checkbox(
    name: "CheckBox",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.none,
    mayHaveRelatedAction: true,
  ),
  decoratedBox(
    name: "DecoratedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  center(
    name: "Center",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  elevatedButton(
    name: "ElevatedButton",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  outlinedButton(
    name: "OutlinedButton",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  filledButton(
    name: "FilledButton",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  textButton(
    name: "TextButton",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  positioned(
    name: "Positioned",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  align(
    name: "Align",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  transform(
    name: "Transform",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  richText(
    name: "RichText",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  wrap(
    name: "Wrap",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  lifecycleStateListener(
    name: "LifecycleStateListener",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  component(
    name: "Component",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.component,
  ),
  singleChildScrollview(
    name: "SingleChildScrollView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  radio(
    name: "Radio",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  radioGroupContext(
    name: "RadioGroupContext",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  ignorePointer(
    name: "IgnorePointer",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  opacity(
    name: "Opacity",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  slider(
    name: "Slider",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
    mayHaveRelatedAction: true,
  ),
  fittedBox(
    name: "FittedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  switch_(
    name: "Switch",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.none,
    mayHaveRelatedAction: true,
  ),
  subtree(
    name: "Subtree",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  meta(
    name: "Meta",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  listView(
    name: "ListView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
    mayHaveRelatedAction: true,
  ),
  repaintBoundary(
    name: "RepaintBoundary",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  overflowBox(
    name: "OverflowBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  animatedSize(
    name: "AnimatedSize",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  intrinsicHeight(
    name: "IntrinsicHeight",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  intrinsicWidth(
    name: "IntrinsicWidth",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  rotatedBox(
    name: "RotatedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  constrainedBox(
    name: "ConstrainedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  backdropFilter(
    name: "BackdropFilter",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  animatedOpacity(
    name: "AnimatedOpacity",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  remoteSubtree(
    name: "RemoteSubtree",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  safeArea(
    name: "SafeArea",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  gridView(
    name: "GridView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
    mayHaveRelatedAction: true,
  ),
  card(
    name: "Card",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  appBar(
    name: "AppBar",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  scaffold(
    name: "Scaffold",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  inkWell(
    name: "InkWell",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  carouselView(
    name: "CarouselView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  animatedContainer(
    name: "AnimatedContainer",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedAlign(
    name: "AnimatedAlign",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedRotation(
    name: "AnimatedRotation",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedPadding(
    name: "AnimatedPadding",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedPositioned(
    name: "AnimatedPositioned",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedScale(
    name: "AnimatedScale",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  flexibleSpaceBar(
    name: "FlexibleSpaceBar",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  sliverPadding(
    name: "SliverPadding",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  customScrollView(
    name: "CustomScrollView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  sliverFillRemaining(
    name: "SliverFillRemaining",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverToBoxAdapter(
    name: "SliverToBoxAdapter",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverFillViewport(
    name: "SliverFillViewport",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  sliverOpacity(
    name: "SliverOpacity",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverVisibility(
    name: "SliverVisibility",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  sliverAnimatedOpacity(
    name: "SliverAnimatedOpacity",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  sliverOffstage(
    name: "SliverOffstage",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverIgnorePointer(
    name: "SliverIgnorePointer",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverSafeArea(
    name: "SliverSafeArea",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sliverList(
    name: "SliverList",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
    mayHaveRelatedAction: true,
  ),
  sliverAppBar(
    name: "SliverAppBar",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  sliverGrid(
    name: "SliverGrid",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
    mayHaveRelatedAction: true,
  ),
  absorbPointer(
    name: "AbsorbPointer",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  offstage(
    name: "Offstage",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  animatedCrossFade(
    name: "AnimatedCrossFade",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.multi,
  ),
  physicalModel(
    name: "PhysicalModel",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  animatedPhysicalModel(
    name: "AnimatedPhysicalModel",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedBuilder(
    name: "AnimatedBuilder",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  animatedSlide(
    name: "AnimatedSlide",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  fragment(
    name: "Fragment",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.fragment,
  ),
  animatedPositionedDirectional(
    name: "AnimatedPositionedDirectional",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  clipRect(
    name: "ClipRect",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  clipOval(
    name: "ClipOval",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  pageView(
    name: "PageView",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  mergeSemantics(
    name: "MergeSemantics",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  badge(
    name: "Badge",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  baseline(
    name: "Baseline",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  limitedBox(
    name: "LimitedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  fractionallySizedBox(
    name: "FractionallySizedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  sizedOverflowBox(
    name: "SizedOverflowBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  aspectRatio(
    name: "AspectRatio",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  fractionalTranslation(
    name: "FractionalTranslation",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  excludeSemantics(
    name: "ExcludeSemantics",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  unconstrainedBox(
    name: "UnconstrainedBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  semantics(
    name: "Semantics",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  visibility(
    name: "Visibility",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  tooltip(
    name: "Tooltip",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.single,
  ),
  interactiveViewer(
    name: "InteractiveViewer",
    isControlledByDefault: true,
    childRelation: ElementChildRelation.single,
  ),
  dismissible(
    name: "Dismissible",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.multi,
  ),
  external(
    name: "External",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
  ),
  skeletonBox(
    name: "SkeletonBox",
    isControlledByDefault: false,
    childRelation: ElementChildRelation.none,
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
  /// Prefer [ElementChildRelation] constants; values match [WidgetDescriptor.childRelation].
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
  static ElementType value(String name) {
    if (enableExternalLibrarySupport) {
      if (enableCoreWidgetsOveeride) {
        if (DuitRegistry.hasDescriptor(name)) {
          return ElementType.external;
        } else {
          final elementType = _stringToTypeLookupTable[name];
          if (elementType != null) {
            return elementType;
          }
          throw ArgumentError(
            "Unknown element type: $name",
          );
        }
      } else {
        final elementType = _stringToTypeLookupTable[name];

        if (elementType != null) {
          return elementType;
        } else if (DuitRegistry.hasDescriptor(name)) {
          return ElementType.external;
        } else {
          throw ArgumentError(
            "Unknown element type: $name",
          );
        }
      }
    } else {
      final elementType = _stringToTypeLookupTable[name];
      if (elementType != null) {
        return elementType;
      } else {
        throw ArgumentError(
          "Unknown element type: $name",
        );
      }
    }
  }

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
  static ElementType? valueOrNull(String name) {
    if (enableExternalLibrarySupport) {
      if (enableCoreWidgetsOveeride) {
        if (DuitRegistry.hasDescriptor(name)) {
          return ElementType.external;
        } else {
          final elementType = _stringToTypeLookupTable[name];
          if (elementType != null) {
            return elementType;
          }
          throw ArgumentError(
            "Unknown element type: $name",
          );
        }
      } else {
        final elementType = _stringToTypeLookupTable[name];

        if (elementType != null) {
          return elementType;
        } else if (DuitRegistry.hasDescriptor(name)) {
          return ElementType.external;
        } else {
          throw ArgumentError(
            "Unknown element type: $name",
          );
        }
      }
    } else {
      return _stringToTypeLookupTable[name];
    }
  }
}

const _stringToTypeLookupTable = <String, ElementType>{
  "Row": ElementType.row,
  "Column": ElementType.column,
  "Stack": ElementType.stack,
  "Expanded": ElementType.expanded,
  "Flexible": ElementType.flexible,
  "SizedBox": ElementType.sizedBox,
  "Text": ElementType.text,
  "Image": ElementType.image,
  "Icon": ElementType.icon,
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
  "OutlinedButton": ElementType.outlinedButton,
  "FilledButton": ElementType.filledButton,
  "TextButton": ElementType.textButton,
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
  "AnimatedPositionedDirectional": ElementType.animatedPositionedDirectional,
  "ClipRect": ElementType.clipRect,
  "ClipOval": ElementType.clipOval,
  "PageView": ElementType.pageView,
  "Badge": ElementType.badge,
  "AspectRatio": ElementType.aspectRatio,
  "Baseline": ElementType.baseline,
  "LimitedBox": ElementType.limitedBox,
  "FractionallySizedBox": ElementType.fractionallySizedBox,
  "SizedOverflowBox": ElementType.sizedOverflowBox,
  "FractionalTranslation": ElementType.fractionalTranslation,
  "UnconstrainedBox": ElementType.unconstrainedBox,
  "Semantics": ElementType.semantics,
  "ExcludeSemantics": ElementType.excludeSemantics,
  "MergeSemantics": ElementType.mergeSemantics,
  "Visibility": ElementType.visibility,
  "Tooltip": ElementType.tooltip,
  "InteractiveViewer": ElementType.interactiveViewer,
  "Dismissible": ElementType.dismissible,
  "SkeletonBox": ElementType.skeletonBox,
};
