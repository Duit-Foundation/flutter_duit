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
  "persistentFooterButtons",
  "background",
};

/// A [ThemeToken] for attended widget-related themes.
///
/// This token handles theme data for widgets that implement the [AttendedModel],
/// excluding properties associated with attended model attributes.
final class AttendedWidgetThemeToken extends ThemeToken {
  /// Creates an [AttendedWidgetThemeToken] with the given theme [data] and [type].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for attended widgets, excluding attended model-specific fields.
  const AttendedWidgetThemeToken(
    Map<String, dynamic> data,
    String type,
  ) : super(
          _attendedWidgetExcludedFields,
          data,
          type,
        );
}

/// A [ThemeToken] for radio group context-related themes.
///
/// This token handles theme data for radio group context widgets,
/// excluding group value and attended widget properties.
final class RadioGroupContextThemeToken extends ThemeToken {
  /// Creates a [RadioGroupContextThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for radio group context widgets.
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

/// A [ThemeToken] for radio button-related themes.
///
/// This token handles theme data for radio button widgets,
/// excluding attended widget and animated owner properties.
final class RadioThemeToken extends ThemeToken {
  /// Creates a [RadioThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for radio button widgets.
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

/// A [ThemeToken] for image-related themes.
///
/// This token handles theme data for image widgets,
/// excluding image source, byte data, and animated owner properties.
final class ImageThemeToken extends ThemeToken {
  /// Creates an [ImageThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for image widgets.
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

/// A [ThemeToken] for implicit animatable widget-related themes.
///
/// This token handles theme data for widgets that support implicit animations,
/// excluding animation end callback properties.
final class ImplicitAnimatableThemeToken extends ThemeToken {
  /// Creates an [ImplicitAnimatableThemeToken] with the given theme [data] and [type].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for implicit animatable widgets.
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

/// A [ThemeToken] for rich text-related themes.
///
/// This token handles theme data for rich text widgets,
/// excluding text span content and animated owner properties.
final class RichTextThemeToken extends ThemeToken {
  /// Creates a [RichTextThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for rich text widgets.
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

/// A [ThemeToken] for slider-related themes.
///
/// This token handles theme data for slider widgets,
/// excluding change callbacks and attended widget properties.
final class SliderThemeToken extends ThemeToken {
  /// Creates a [SliderThemeToken] with the given theme [data].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for slider widgets.
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

/// A [ThemeToken] for widgets that exclude gesture callback-related themes.
///
/// This token handles theme data for widgets that need to exclude
/// gesture callback properties and animated owner properties.
final class ExcludeGestureCallbacksThemeToken extends ThemeToken {
  /// Creates an [ExcludeGestureCallbacksThemeToken] with the given theme [data] and [type].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for widgets, excluding all gesture callback properties.
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

/// A [ThemeToken] for widgets that exclude child-related themes.
///
/// This token handles theme data for widgets that need to exclude
/// child subview properties and animated owner properties.
final class ExcludeChildThemeToken extends ThemeToken {
  /// Creates an [ExcludeChildThemeToken] with the given theme [data] and [type].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for widgets, excluding child subview properties.
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

/// A [ThemeToken] for dynamic child holder-related themes.
///
/// This token handles theme data for widgets that dynamically manage child widgets,
/// excluding child object definitions and constructor properties.
final class DynamicChildHolderThemeToken extends ThemeToken {
  /// Creates a [DynamicChildHolderThemeToken] with the given theme [data] and [type].
  ///
  /// The [data] map contains key-value pairs representing the theme
  /// properties for dynamic child holder widgets.
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
