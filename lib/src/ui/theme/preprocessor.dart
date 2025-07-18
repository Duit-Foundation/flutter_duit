import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import 'package:flutter_duit/src/ui/theme/tokens.dart';

final class DuitThemePreprocessor extends ThemePreprocessor {
  const DuitThemePreprocessor({
    super.customWidgetTokenizer,
    super.overrideWidgetTokenizer,
  });

  @override
  ThemeToken createToken(
    String widgetType,
    Map<String, dynamic> themeData,
  ) {
    return switch (widgetType) {
      ElementType.text => TextThemeToken(
          themeData,
        ),
      ElementType.image => ImageThemeToken(
          themeData,
        ),
      ElementType.align ||
      ElementType.backdropFilter ||
      ElementType.coloredBox ||
      ElementType.constrainedBox ||
      ElementType.decoratedBox ||
      ElementType.expanded ||
      ElementType.fittedBox ||
      ElementType.row ||
      ElementType.column ||
      ElementType.sizedBox ||
      ElementType.container ||
      ElementType.overflowBox ||
      ElementType.padding ||
      ElementType.positioned ||
      ElementType.opacity ||
      ElementType.rotatedBox ||
      ElementType.stack ||
      ElementType.wrap ||
      ElementType.transform ||
      ElementType.card =>
        AnimatedPropOwnerThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.animatedOpacity => ImplicitAnimatableThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.gestureDetector ||
      ElementType.inkWell =>
        ExcludeGestureCallbacksThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.appBar || ElementType.scaffold => ExcludeChildThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.gridView ||
      ElementType.listView =>
        DynamicChildHolderThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.elevatedButton ||
      ElementType.center ||
      ElementType.ignorePointer ||
      ElementType.repaintBoundary ||
      ElementType.singleChildScrollview =>
        DefaultThemeToken(
          themeData,
          widgetType,
        ),
      ElementType.checkbox ||
      ElementType.switchW ||
      ElementType.textField =>
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
      _ => customWidgetTokenizer?.call(widgetType, themeData) ??
          const UnknownThemeToken(),
    };
  }
}
