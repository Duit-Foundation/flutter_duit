import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/ui/index.dart";

/// A theme preprocessor implementation for Duit widgets.
///
/// This class is responsible for creating appropriate theme tokens based on
/// widget types. It handles the conversion of theme data into specific theme
/// tokens that can be used by Duit widgets during rendering.
///
/// Example usage:
/// ```dart
/// final preprocessor = DuitThemePreprocessor();
/// final token = preprocessor.createToken('text', {'color': 'red'});
/// ```
final class DuitThemePreprocessor extends ThemePreprocessor {
  /// Creates a new instance of [DuitThemePreprocessor].
  ///
  /// Parameters:
  /// - [customWidgetTokenizer]: Optional custom tokenizer for handling
  ///   custom widget types that are not built into the preprocessor.
  /// - [overrideWidgetTokenizer]: Optional tokenizer that can override
  ///   the default tokenization behavior for built-in widget types.
  const DuitThemePreprocessor({
    super.customWidgetTokenizer,
    super.overrideWidgetTokenizer,
  });

  /// Creates a theme token for the specified widget type and theme data.
  ///
  /// This method analyzes the [widgetType] and creates the most appropriate
  /// theme token for that widget type. The [themeData] contains the styling
  /// information that will be encapsulated in the returned token.
  ///
  /// Parameters:
  /// - [widgetType]: The type of widget for which to create a theme token.
  ///   Should match one of the types defined in [ElementType].
  /// - [themeData]: A map containing the theme/styling data for the widget.
  ///
  /// Returns:
  /// A [ThemeToken] instance appropriate for the given widget type.
  /// If the widget type is not recognized, it will fall back to
  /// [customWidgetTokenizer] if provided, or return [UnknownThemeToken].
  ///
  /// Example:
  /// ```dart
  /// final token = preprocessor.createToken(
  ///   ElementType.text,
  ///   {'fontSize': 16, 'color': '#FF0000'}
  /// );
  /// ```
  @override
  ThemeToken createToken(
    String widgetType,
    Map<String, dynamic> themeData,
  ) {
    final type = ElementType.valueOrNull(widgetType);
    return switch (type) {
      ElementType.text => TextThemeToken(
          themeData,
        ),
      ElementType.image => ImageThemeToken(
          themeData,
        ),
      ElementType.align ||
      ElementType.aspectRatio ||
      ElementType.backdropFilter ||
      ElementType.baseline ||
      ElementType.coloredBox ||
      ElementType.constrainedBox ||
      ElementType.decoratedBox ||
      ElementType.expanded ||
      ElementType.fittedBox ||
      ElementType.fractionallySizedBox ||
      ElementType.fractionalTranslation ||
      ElementType.row ||
      ElementType.column ||
      ElementType.limitedBox ||
      ElementType.sizedBox ||
      ElementType.container ||
      ElementType.overflowBox ||
      ElementType.padding ||
      ElementType.positioned ||
      ElementType.opacity ||
      ElementType.rotatedBox ||
      ElementType.sizedOverflowBox ||
      ElementType.stack ||
      ElementType.wrap ||
      ElementType.transform ||
      ElementType.card =>
        AnimatedPropOwnerThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.animatedOpacity ||
      ElementType.animatedPositioned ||
      ElementType.animatedScale ||
      ElementType.animatedRotation ||
      ElementType.animatedPadding ||
      ElementType.animatedAlign ||
      ElementType.animatedSize ||
      ElementType.animatedPhysicalModel ||
      ElementType.animatedSlide ||
      ElementType.animatedContainer ||
      ElementType.animatedCrossFade ||
      ElementType.sliverAnimatedOpacity ||
      ElementType.animatedPositionedDirectional =>
        ImplicitAnimatableThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.gestureDetector ||
      ElementType.inkWell =>
        ExcludeGestureCallbacksThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.appBar ||
      ElementType.scaffold ||
      ElementType.flexibleSpaceBar =>
        ExcludeChildThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.gridView ||
      ElementType.listView ||
      ElementType.pageView ||
      ElementType.sliverList ||
      ElementType.sliverAppBar ||
      ElementType.sliverGrid =>
        DynamicChildHolderThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.elevatedButton ||
      ElementType.outlinedButton ||
      ElementType.filledButton ||
      ElementType.textButton ||
      ElementType.center ||
      ElementType.clipRect ||
      ElementType.clipOval ||
      ElementType.ignorePointer ||
      ElementType.repaintBoundary ||
      ElementType.singleChildScrollview ||
      ElementType.intrinsicHeight ||
      ElementType.intrinsicWidth ||
      ElementType.safeArea ||
      ElementType.carouselView ||
      ElementType.customScrollView ||
      ElementType.sliverPadding ||
      ElementType.sliverFillRemaining ||
      ElementType.sliverToBoxAdapter ||
      ElementType.sliverFillViewport ||
      ElementType.sliverOpacity ||
      ElementType.sliverVisibility ||
      ElementType.absorbPointer ||
      ElementType.offstage ||
      ElementType.physicalModel ||
      ElementType.semantics ||
      ElementType.sliverOffstage ||
      ElementType.sliverIgnorePointer ||
      ElementType.sliverSafeArea ||
      ElementType.excludeSemantics ||
      ElementType.mergeSemantics ||
      ElementType.semantics ||
      ElementType.visibility ||
      ElementType.badge =>
        DefaultThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.checkbox ||
      ElementType.switch_ ||
      ElementType.textField ||
      ElementType.meta =>
        AttendedWidgetThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.radioGroupContext => RadioGroupContextThemeToken(
          themeData,
        ),
      ElementType.radio => RadioThemeToken(
          themeData,
        ),
      ElementType.slider => SliderThemeToken(
          themeData,
        ),
      ElementType.lifecycleStateListener ||
      ElementType.component ||
      ElementType.subtree ||
      ElementType.animatedBuilder ||
      ElementType.remoteSubtree =>
        const UnknownThemeToken(),
      ElementType.richText => RichTextThemeToken(
          themeData,
        ),
      _ => customWidgetTokenizer?.call(widgetType, themeData) ??
          const UnknownThemeToken(),
    };
  }
}
