import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';

const _animatedOwnerExcludedFields = {
  "parentBuilderId",
  "affectedProperties",
};

const _attendedWidgetExcludedFields = {
  "value",
};

const _subviewsExcludedFields = {
  "leading",
  "title",
  "actions",
  "bottom",
  "flexibleSpace",
  "body",
  "appBar",
  "bottomNavigationBar",
  "floatingActionButton",
  "bottomSheet",
  "persistentFooterButtons"
};

// Token excluding properties associated with [AttendedModel] attributes
final class AttendedWidgetThemeToken extends ThemeToken {
  const AttendedWidgetThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          _attendedWidgetExcludedFields,
          data,
          type,
        );
}

final class RadioGroupContextThemeToken extends ThemeToken {
  const RadioGroupContextThemeToken(
    Map<String, dynamic> data,
  ) : super(
          const {
            ..._attendedWidgetExcludedFields,
            "groupValue",
          },
          data,
          ElementType.radioGroupContext,
        );
}

final class RadioThemeToken extends ThemeToken {
  const RadioThemeToken(
    Map<String, dynamic> data,
  ) : super(
          const {
            ..._attendedWidgetExcludedFields,
            ..._animatedOwnerExcludedFields,
          },
          data,
          ElementType.radio,
        );
}

/// A [ThemeToken] for text-related themes.
///
/// This token handles theme data specifically for text widgets.
final class TextThemeToken extends ThemeToken {
  /// Creates a [TextThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for text widgets.
  const TextThemeToken(Map<String, dynamic> data)
      : super(
          const {
            "data",
            ..._animatedOwnerExcludedFields,
          },
          data,
          ElementType.text,
        );
}

/// A [ThemeToken] for animated property owner-related themes.
final class AnimatedPropOwnerThemeToken extends ThemeToken {
  /// Creates a [AnimatedPropOwnerThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for animated property owner widgets.
  const AnimatedPropOwnerThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          _animatedOwnerExcludedFields,
          data,
          type,
        );
}

final class ImageThemeToken extends ThemeToken {
  const ImageThemeToken(Map<String, dynamic> data)
      : super(
          const {
            "type",
            "src",
            "byteData",
            ..._animatedOwnerExcludedFields,
          },
          data,
          ElementType.image,
        );
}

final class ImplicitAnimatableThemeToken extends ThemeToken {
  const ImplicitAnimatableThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          const {
            "onEnd",
          },
          data,
          type,
        );
}

final class RichTextThemeToken extends ThemeToken {
  const RichTextThemeToken(Map<String, dynamic> data)
      : super(
          const {
            ..._animatedOwnerExcludedFields,
            "textSpan",
          },
          data,
          ElementType.richText,
        );
}

final class SliderThemeToken extends ThemeToken {
  const SliderThemeToken(Map<String, dynamic> data)
      : super(
          const {
            ..._attendedWidgetExcludedFields,
            "onChanged",
            "onChangeStart",
            "onChangeEnd",
          },
          data,
          ElementType.slider,
        );
}

final class ExcludeGestureCallbacksThemeToken extends ThemeToken {
  const ExcludeGestureCallbacksThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          const {
            ..._animatedOwnerExcludedFields,
            "onTap",
            "onTapDown",
            "onTapUp",
            "onTapCancel",
            "onDoubleTap",
            "onDoubleTapDown",
            "onDoubleTapCancel",
            "onLongPressDown",
            "onLongPressCancel",
            "onLongPress",
            "onLongPressStart",
            "onLongPressMoveUpdate",
            "onLongPressUp",
            "onLongPressEnd",
            "onPanStart",
            "onPanDown",
            "onPanUpdate",
            "onPanEnd",
            "onPanCancel",
            "onSecondaryTapDown",
            "onSecondaryTapCancel",
            "onSecondaryTap",
            "onSecondaryTapUp",
          },
          data,
          type,
        );
}

final class ExcludeChildThemeToken extends ThemeToken {
  const ExcludeChildThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          const {
            ..._animatedOwnerExcludedFields,
            ..._subviewsExcludedFields,
          },
          data,
          type,
        );
}

final class DynamicChildHolderThemeToken extends ThemeToken {
  const DynamicChildHolderThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          const {
            "childObjects",
            "constructor",
            "type",
            "restorationId",
          },
          data,
          type,
        );
}
