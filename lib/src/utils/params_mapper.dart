import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A utility class for mapping parameter values to their corresponding Flutter widget properties.
final class AttributeValueMapper {
  //<editor-fold desc="Text">
  static TextSpan toTextSpan(JSONObject? json) {
    assert(json != null, "TextSpan json cannot be null");

    final children = json!['children'];

    List<InlineSpan> spanChildren = [];

    if (children != null) {
      for (final child in children) {
        spanChildren.add(AttributeValueMapper.toTextSpan(child));
      }
    }

    return TextSpan(
      text: json['text'],
      children: spanChildren.isNotEmpty ? spanChildren : null,
      style: AttributeValueMapper.toTextStyle(json['style']),
      spellOut: json['spellOut'],
    );
  }

  static TextBaseline? toTextBaseline(String? value) {
    if (value == null) return null;

    switch (value) {
      case "alphabetic":
        return TextBaseline.alphabetic;
      case "ideographic":
        return TextBaseline.ideographic;
    }

    return null;
  }

  static TextWidthBasis? toTextWidthBasis(String? value) {
    if (value == null) return null;

    switch (value) {
      case "parent":
        return TextWidthBasis.parent;
      case "longestLine":
        return TextWidthBasis.longestLine;
    }

    return null;
  }

  static TextLeadingDistribution toTextLeadingDistribution(
    String? value,
  ) {
    if (value == null) return TextLeadingDistribution.proportional;

    switch (value) {
      case "even":
        return TextLeadingDistribution.even;
      case "italic":
        return TextLeadingDistribution.proportional;
    }

    return TextLeadingDistribution.proportional;
  }

  static TextHeightBehavior? toTextHeightBehavior(JSONObject? value) {
    if (value == null) return null;

    return TextHeightBehavior(
      applyHeightToFirstAscent: value['applyHeightToFirstAscent'] ?? true,
      applyHeightToLastDescent: value['applyHeightToLastDescent'] ?? true,
      leadingDistribution:
          toTextLeadingDistribution(value['leadingDistribution']),
    );
  }

  static TextScaler toTextScaler(JSONObject? value) {
    if (value == null) return TextScaler.noScaling;

    return TextScaler.linear(NumUtils.toDoubleWithNullReplacement(
      value['textScaleFactor'],
      1,
    ));
  }

  static StrutStyle? toStrutStyle(JSONObject? value) {
    if (value == null) return null;

    return StrutStyle(
      fontFamily: value['fontFamily'],
      fontSize: NumUtils.toDouble(value['fontSize']),
      height: NumUtils.toDouble(value['height']),
      leading: NumUtils.toDouble(value['leading']),
      fontWeight: toFontWeight(value['fontWeight']),
      fontStyle: toFontStyle(value['fontStyle']),
      forceStrutHeight: value['forceStrutHeight'],
      debugLabel: value['debugLabel'],
    );
  }

  static FontStyle? toFontStyle(String? value) {
    if (value == null) return null;

    switch (value) {
      case "normal":
        return FontStyle.normal;
      case "italic":
        return FontStyle.italic;
    }

    return null;
  }

  /// Converts a string value to a [TextAlign] value.
  ///
  /// Returns the corresponding [TextAlign] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  static TextAlign? toTextAlign(String? value) {
    if (value == null) return null;

    switch (value) {
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      case "center":
        return TextAlign.center;
      case "justify":
        return TextAlign.justify;
      case "end":
        return TextAlign.end;
      case "start":
        return TextAlign.start;
    }

    return null;
  }

  static TextDecoration? toTextDecoration(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'none':
        return TextDecoration.none;
      case 'underline':
        return TextDecoration.underline;
      case 'overline':
        return TextDecoration.overline;
      case 'lineThrough':
        return TextDecoration.lineThrough;
      default:
        return null;
    }
  }

  static TextDecorationStyle? toTextDecorationStyle(String? value) {
    if (value == null) return null;

    switch (value) {
      case 'solid':
        return TextDecorationStyle.solid;
      case 'double':
        return TextDecorationStyle.double;
      case 'dotted':
        return TextDecorationStyle.dotted;
      case 'dashed':
        return TextDecorationStyle.dashed;
      case 'wavy':
        return TextDecorationStyle.wavy;
      default:
        return null;
    }
  }

  /// Converts an integer value to a [FontWeight] value.
  ///
  /// Returns the corresponding [FontWeight] value for the given integer [value].
  /// If [value] is `null`, returns `null`.
  static FontWeight? toFontWeight(int? value) {
    if (value == null) return null;

    switch (value) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
    }

    return null;
  }

  /// Converts a string value to a [TextOverflow] value.
  ///
  /// Returns the corresponding [TextOverflow] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  static TextOverflow? toTextOverflow(String? value) {
    if (value == null) return null;

    switch (value) {
      case "fade":
        return TextOverflow.fade;
      case "ellipsis":
        return TextOverflow.ellipsis;
      case "clip":
        return TextOverflow.clip;
      case "visible":
        return TextOverflow.visible;
    }

    return null;
  }

  /// Converts a map of style values to a [TextStyle] object.
  ///
  /// Returns a [TextStyle] object with the properties specified in the given [styleMap].
  /// The [styleMap] should be a map with the following keys:
  /// - 'fontSize': the font size as a double value.
  /// - 'fontWeight': the font weight as an integer value.
  /// - 'fontStyle': the font style as a [FontStyle] value (e.g., 'normal', 'italic').
  /// - 'letterSpacing': the letter spacing as a double value.
  /// - 'wordSpacing': the word spacing as a double value.
  /// - 'color': the color as a [Color] value.
  /// - 'backgroundColor': the background color as a [Color] value.
  /// - 'decoration': the text decoration as a [TextDecoration] value.
  /// - 'decorationColor': the decoration color as a [Color] value.
  /// - 'decorationStyle': the decoration style as a [TextDecorationStyle] value.
  /// - 'decorationThickness': the decoration thickness as a double value.
  ///
  /// If any of the properties are missing or invalid, they will be ignored.
  /// If [styleMap] is `null` or empty, returns `null`.
  static TextStyle? toTextStyle(dynamic json) {
    if (json == null) return null;

    if (json is TextStyle) return json;

    final size = json["fontSize"] as num?;

    return TextStyle(
      color: ColorUtils.tryParseColor(json["color"]),
      fontFamily: json["fontFamily"],
      fontWeight: toFontWeight(json["fontWeight"]),
      fontSize: size?.toDouble(),
      letterSpacing: NumUtils.toDouble(json["letterSpacing"]),
      wordSpacing: NumUtils.toDouble(json["wordSpacing"]),
      height: NumUtils.toDouble(json["height"]),
      decoration: toTextDecoration(json["decoration"]),
      decorationColor:
          ColorUtils.tryParseNullableColor(json['decorationColor']),
      decorationStyle: toTextDecorationStyle(json['decorationStyle']),
      decorationThickness: NumUtils.toDouble(json['decorationThickness']),
    );
  }

  /// Converts a string value to a [TextDirection] value.
  ///
  /// Returns the corresponding [TextDirection] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid text direction, returns [TextDirection.ltr] as the default.
  static TextDirection? toTextDirection(String? value) {
    if (value == null) return null;

    switch (value) {
      case "rtl":
        return TextDirection.rtl;
      case "ltr":
        return TextDirection.ltr;
    }

    return null;
  }

  //</editor-fold>

  //<editor-fold desc="Flex and container props">
  static Size toSize(dynamic json) {
    if (json == null) return Size.zero;

    if (json is Size) return json;

    return Size(
      NumUtils.toDoubleWithNullReplacement(
        json["width"],
        double.infinity,
      ),
      NumUtils.toDoubleWithNullReplacement(
        json["height"],
        double.infinity,
      ),
    );
  }

  static Axis toAxis(String? value, [Axis? defaultValue]) {
    if (value == null) return defaultValue ?? Axis.vertical;

    switch (value) {
      case "horizontal":
        return Axis.horizontal;
      case "vertical":
        return Axis.vertical;
    }

    return Axis.vertical;
  }

  static WrapCrossAlignment? toWrapCrossAlignment(String? value) {
    if (value == null) return null;

    switch (value) {
      case "start":
        return WrapCrossAlignment.start;
      case "end":
        return WrapCrossAlignment.end;
      case "center":
        return WrapCrossAlignment.center;
    }

    return null;
  }

  static WrapAlignment? toWrapAlignment(String? value) {
    if (value == null) return null;
    switch (value) {
      case "start":
        return WrapAlignment.start;
      case "end":
        return WrapAlignment.end;
      case "center":
        return WrapAlignment.center;
      case "spaceBetween":
        return WrapAlignment.spaceBetween;
      case "spaceAround":
        return WrapAlignment.spaceAround;
      case "spaceEvenly":
        return WrapAlignment.spaceEvenly;
    }

    return null;
  }

  /// Converts a map of constraint values to a [BoxConstraints] object.
  ///
  /// Returns a [BoxConstraints] object with the properties specified in the given [constraintsMap].
  /// The [constraintsMap] should be a map with the following keys:
  /// - 'minWidth': the minimum width as a double value.
  /// - 'maxWidth': the maximum width as a double value.
  /// - 'minHeight': the minimum height as a double value.
  /// - 'maxHeight': the maximum height as a double value.
  ///
  /// If any of the properties are missing or invalid, they will be ignored.
  /// If [constraintsMap] is `null` or empty, returns `null`.
  static BoxConstraints toBoxConstraints(dynamic json) {
    if (json == null) return const BoxConstraints();

    if (json is BoxConstraints) return json;

    return BoxConstraints(
      minWidth: NumUtils.toDoubleWithNullReplacement(
        json["minWidth"],
        0.0,
      ),
      maxWidth: NumUtils.toDoubleWithNullReplacement(
        json["maxWidth"],
        double.infinity,
      ),
      minHeight: NumUtils.toDoubleWithNullReplacement(
        json["minHeight"],
        0.0,
      ),
      maxHeight: NumUtils.toDoubleWithNullReplacement(
        json["maxHeight"],
        double.infinity,
      ),
    );
  }

  /// Converts a string value to a [StackFit] value.
  ///
  /// Returns the corresponding [StackFit] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid stack fit, returns [StackFit.loose] as the default.
  static StackFit toStackFit(String? value) {
    if (value == null) return StackFit.loose;

    switch (value) {
      case "expand":
        return StackFit.expand;
      case "passthrough":
        return StackFit.passthrough;
      case "loose":
        return StackFit.loose;
    }

    return StackFit.loose;
  }

  static OverflowBoxFit toOverflowBoxFit(String? value) {
    if (value == null) return OverflowBoxFit.max;

    switch (value) {
      case "max":
        return OverflowBoxFit.max;
      case "deferToChild":
        return OverflowBoxFit.deferToChild;
    }

    return OverflowBoxFit.max;
  }

  /// Converts a string value to an [Alignment] value.
  ///
  /// Returns the corresponding [Alignment] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid alignment, returns [Alignment.center] as the default.
  static Alignment toAlignment(dynamic value, [Alignment? defaultValue]) {
    if (value == null) return defaultValue ?? Alignment.topLeft;

    if (value is Alignment) return value;

    switch (value) {
      case "topCenter":
        return Alignment.topCenter;
      case "topLeft":
        return Alignment.topLeft;
      case "topRight":
        return Alignment.topRight;
      case "bottomCenter":
        return Alignment.bottomCenter;
      case "bottomLeft":
        return Alignment.bottomLeft;
      case "bottomRight":
        return Alignment.bottomRight;
      case "center":
        return Alignment.center;
      case "centerLeft":
        return Alignment.centerLeft;
      case "centerRight":
        return Alignment.centerRight;
    }

    return defaultValue ?? Alignment.topLeft;
  }

  /// Converts a string value to an [AlignmentDirectional] value.
  ///
  /// Returns the corresponding [AlignmentDirectional] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid alignment, returns [AlignmentDirectional.centerStart] as the default.
  static AlignmentDirectional toAlignmentDirectional(String? value) {
    if (value == null) return AlignmentDirectional.topStart;

    switch (value) {
      case "topStart":
        return AlignmentDirectional.topStart;
      case "topCenter":
        return AlignmentDirectional.topCenter;
      case "topEnd":
        return AlignmentDirectional.topEnd;
      case "bottomCenter":
        return AlignmentDirectional.bottomCenter;
      case "bottomEnd":
        return AlignmentDirectional.bottomEnd;
      case "bottomStart":
        return AlignmentDirectional.bottomStart;
      case "center":
        return AlignmentDirectional.center;
      case "centerStart":
        return AlignmentDirectional.centerStart;
      case "centerEnd":
        return AlignmentDirectional.centerEnd;
    }

    return AlignmentDirectional.topStart;
  }

  /// Converts a string value to a [MainAxisAlignment] value.
  ///
  /// Returns the corresponding [MainAxisAlignment] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid main axis alignment, returns [MainAxisAlignment.start] as the default.
  static MainAxisAlignment? toMainAxisAlignment(String? value) {
    if (value == null) return null;

    switch (value) {
      case "center":
        return MainAxisAlignment.center;
      case "start":
        return MainAxisAlignment.start;
      case "end":
        return MainAxisAlignment.end;
      case "spaceAround":
        return MainAxisAlignment.spaceAround;
      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;
      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;
    }

    return null;
  }

  /// Converts a string value to a [CrossAxisAlignment] value.
  ///
  /// Returns the corresponding [CrossAxisAlignment] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid cross axis alignment, returns [CrossAxisAlignment.start] as the default.
  static CrossAxisAlignment? toCrossAxisAlignment(String? value) {
    if (value == null) return null;

    switch (value) {
      case "center":
        return CrossAxisAlignment.center;
      case "baseline":
        return CrossAxisAlignment.baseline;
      case "stretch":
        return CrossAxisAlignment.stretch;
      case "start":
        return CrossAxisAlignment.start;
      case "end":
        return CrossAxisAlignment.end;
    }

    return null;
  }

  /// Converts a string value to a [Clip] value.
  ///
  /// Returns the corresponding [Clip] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid clip value, returns [Clip.none] as the default.
  static Clip toClip(String? value, [Clip? defaultValue]) {
    if (value == null) return defaultValue ?? Clip.hardEdge;

    switch (value) {
      case "hardEdge":
        return Clip.hardEdge;
      case "antiAlias":
        return Clip.antiAlias;
      case "antiAliasWithSaveLayer":
        return Clip.antiAliasWithSaveLayer;
      case "none":
        return Clip.none;
    }

    return defaultValue ?? Clip.hardEdge;
  }

  static Clip toClipNonNull(String? value, Clip? defaultValue) {
    if (value == null) return defaultValue ?? Clip.hardEdge;

    switch (value) {
      case "hardEdge":
        return Clip.hardEdge;
      case "antiAlias":
        return Clip.antiAlias;
      case "antiAliasWithSaveLayer":
        return Clip.antiAliasWithSaveLayer;
      case "none":
        return Clip.none;
    }

    return defaultValue ?? Clip.hardEdge;
  }

  /// Converts a string value to a [MainAxisSize] value.
  ///
  /// Returns the corresponding [MainAxisSize] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid main axis size, returns [MainAxisSize.max] as the default.
  static MainAxisSize? toMainAxisSize(String? value) {
    if (value == null) return null;

    switch (value) {
      case "min":
        return MainAxisSize.min;
      case "max":
        return MainAxisSize.max;
    }

    return null;
  }

  //</editor-fold>

  //<editor-fold desc="Basic">
  static SliderInteraction? toSliderInteraction(String? value) {
    if (value == null) return null;

    switch (value) {
      case "tapOnly":
        return SliderInteraction.tapOnly;
      case "tapAndSlide":
        return SliderInteraction.tapAndSlide;
      case "slideOnly":
        return SliderInteraction.slideOnly;
      case "slideThumb":
        return SliderInteraction.slideThumb;
    }

    return null;
  }

  static MaterialTapTargetSize? toMaterialTapTargetSize(String? value) {
    if (value == null) return null;

    switch (value) {
      case "shrinkWrap":
        return MaterialTapTargetSize.shrinkWrap;
      case "padded":
        return MaterialTapTargetSize.padded;
    }

    return null;
  }

  /// Converts a string value to a [FilterQuality] value.
  ///
  /// Returns the corresponding [FilterQuality] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid filter quality, returns [FilterQuality.low] as the default.
  static FilterQuality toFilterQuality(String? value) {
    if (value == null) return FilterQuality.low;

    switch (value) {
      case "none":
        return FilterQuality.none;
      case "low":
        return FilterQuality.low;
      case "medium":
        return FilterQuality.medium;
      case "high":
        return FilterQuality.high;
    }

    return FilterQuality.low;
  }

  /// Converts a string value to an [ImageRepeat] value.
  ///
  /// Returns the corresponding [ImageRepeat] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid image repeat value, returns [ImageRepeat.noRepeat] as the default.
  static ImageRepeat toImageRepeat(String? value) {
    if (value == null) return ImageRepeat.noRepeat;

    switch (value) {
      case "noRepeat":
        return ImageRepeat.noRepeat;
      case "repeat":
        return ImageRepeat.repeat;
      case "repeatX":
        return ImageRepeat.repeatX;
      case "repeatY":
        return ImageRepeat.repeatY;
    }

    return ImageRepeat.noRepeat;
  }

  /// Converts a list of integers to a [Uint8List].
  ///
  /// Returns a [Uint8List] containing the values from the given [list].
  /// If [list] is `null`, returns `null`.
  /// If any value in the [list] is not a valid unsigned 8-bit integer (0-255), it will be clamped to that range.
  static Uint8List toUint8List(dynamic value) {
    if (value == null) return Uint8List(0);

    final bytes = value["data"];

    if (bytes != null && bytes is List) {
      final data = List.castFrom<dynamic, int>(bytes);
      return Uint8List.fromList(data);
    }

    if (bytes is String) {
      return base64Decode(bytes);
    }

    return Uint8List(0);
  }

  /// Converts a string value to an [ImageType] value.
  ///
  /// Returns the corresponding [ImageType] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid image type, returns [ImageType.png] as the default.
  static ImageType toImageType(String? value) {
    if (value == null) return ImageType.network;

    switch (value) {
      case "asset":
        return ImageType.asset;
      case "network":
        return ImageType.network;
      case "memory":
        return ImageType.memory;
    }

    return ImageType.network;
  }

  /// Converts a string value to a [BoxFit] value.
  ///
  /// Returns the corresponding [BoxFit] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid box fit value, returns [BoxFit.contain] as the default.
  static BoxFit? toBoxFit(String? value) {
    if (value == null) return null;

    switch (value) {
      case "fill":
        return BoxFit.fill;
      case "contain":
        return BoxFit.contain;
      case "cover":
        return BoxFit.cover;
      case "fitHeight":
        return BoxFit.fitHeight;
      case "fitWidth":
        return BoxFit.fitWidth;
      case "none":
        return BoxFit.none;
      case "scaleDown":
        return BoxFit.scaleDown;
    }

    return null;
  }

  /// Converts a string value to a [BlendMode] value.
  ///
  /// Returns the corresponding [BlendMode] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid blend mode, returns [BlendMode.srcOver] as the default.
  static BlendMode toBlendMode(String? value) {
    if (value == null) return BlendMode.src;

    switch (value) {
      case "clear":
        return BlendMode.clear;
      case "src":
        return BlendMode.src;
      case "dst":
        return BlendMode.dst;
      case "srcOver":
        return BlendMode.srcOver;
      case "dstOver":
        return BlendMode.dstOver;
      case "srcIn":
        return BlendMode.srcIn;
      case "dstIn":
        return BlendMode.dstIn;
      case "srcOut":
        return BlendMode.srcOut;
      case "dstOut":
        return BlendMode.dstOut;
      case "srcATop":
        return BlendMode.srcATop;
      case "dstATop":
        return BlendMode.dstATop;
      case "xor":
        return BlendMode.xor;
      case "plus":
        return BlendMode.plus;
      case "modulate":
        return BlendMode.modulate;
      case "screen":
        return BlendMode.screen;
      case "overlay":
        return BlendMode.overlay;
      case "darken":
        return BlendMode.darken;
      case "lighten":
        return BlendMode.lighten;
      case "colorDodge":
        return BlendMode.colorDodge;
      case "colorBurn":
        return BlendMode.colorBurn;
      case "hardLight":
        return BlendMode.hardLight;
      case "softLight":
        return BlendMode.softLight;
      case "difference":
        return BlendMode.difference;
      case "exclusion":
        return BlendMode.exclusion;
      case "multiply":
        return BlendMode.multiply;
      case "hue":
        return BlendMode.hue;
      case "saturation":
        return BlendMode.saturation;
      case "color":
        return BlendMode.color;
      case "luminosity":
        return BlendMode.luminosity;
    }

    return BlendMode.src;
  }

  static ImageFilter toImageFilter(dynamic value) {
    if (value == null) return ImageFilter.blur();

    if (value is ImageFilter) return value;

    if (value is Map) {
      final fType = value["type"];

      return switch (fType) {
        "blur" || 0 => ImageFilter.blur(
            sigmaX: NumUtils.toDoubleWithNullReplacement(value["radiusX"]),
            sigmaY: NumUtils.toDoubleWithNullReplacement(value["radiusY"]),
            tileMode: value["tileMode"] != null
                ? TileMode.values.byName(value["tileMode"])
                : TileMode.clamp,
          ),
        "compose" || 1 => () {
            final outerFilter =
                value.containsKey("outer") ? value["outer"] : const {};
            final innerFilter =
                value.containsKey("inner") ? value["inner"] : const {};

            return ImageFilter.compose(
              outer: toImageFilter(outerFilter["filter"]),
              inner: toImageFilter(innerFilter["filter"]),
            );
          }(),
        "dilate" || 2 => ImageFilter.dilate(
            radiusX: NumUtils.toDoubleWithNullReplacement(value["radiusX"]),
            radiusY: NumUtils.toDoubleWithNullReplacement(value["radiusY"]),
          ),
        "erode" || 3 => ImageFilter.erode(
            radiusX: NumUtils.toDoubleWithNullReplacement(value["radiusX"]),
            radiusY: NumUtils.toDoubleWithNullReplacement(value["radiusY"]),
          ),
        "matrix" || 4 => ImageFilter.matrix(
            Float64List.fromList(value["matrix4"] as List<double>),
            filterQuality: toFilterQuality(value["filterQuality"]),
          ),
        Object() ||
        null ||
        String() =>
          throw ArgumentError.value(fType, "type", "Invalid ImageFilter type"),
      };
    }

    return ImageFilter.blur();
  }

  /// Converts a string value to a [VerticalDirection] value.
  ///
  /// Returns the corresponding [VerticalDirection] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid vertical direction, returns [VerticalDirection.down] as the default.
  static VerticalDirection? toVerticalDirection(String? value) {
    if (value == null) return null;

    switch (value) {
      case "up":
        return VerticalDirection.up;
      case "down":
        return VerticalDirection.down;
    }

    return null;
  }

  //</editor-fold>

  //<editor-fold desc="Decoration">

  /// Converts a string value to a [BoxShape] value.
  ///
  /// Returns the corresponding [BoxShape] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid box shape, returns [BoxShape.rectangle] as the default.
  static BoxShape toBoxShape(String? value) {
    if (value == null) return BoxShape.rectangle;

    switch (value) {
      case "circle":
        return BoxShape.circle;
      case "rectangle":
        return BoxShape.rectangle;
    }

    return BoxShape.rectangle;
  }

  /// Converts a list of two double values to an [Offset].
  ///
  /// Returns an [Offset] with the given [x] and [y] values.
  /// If [list] is `null` or does not contain exactly two elements, returns `null`.
  static Offset toOffset(JSONObject? json) {
    if (json == null) return Offset.zero;

    return Offset(
      NumUtils.toDoubleWithNullReplacement(json["dx"], 0.0),
      NumUtils.toDoubleWithNullReplacement(json["dy"], 0.0),
    );
  }

  /// Converts a string value to a [BlurStyle] value.
  ///
  /// Returns the corresponding [BlurStyle] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid blur style, returns [BlurStyle.normal] as the default.
  static BlurStyle toBlurStyle(String? value) {
    if (value == null) return BlurStyle.normal;

    switch (value) {
      case "normal":
        return BlurStyle.normal;
      case "solid":
        return BlurStyle.solid;
      case "outer":
        return BlurStyle.outer;
      case "inner":
        return BlurStyle.inner;
    }

    return BlurStyle.normal;
  }

  /// Converts a list of values to a [BoxShadow].
  ///
  /// Returns a [BoxShadow] with the given [color], [offset], [blurRadius], and [spreadRadius].
  /// If any of the values are `null` or if the list does not contain exactly four elements,
  /// returns `null`.
  static List<BoxShadow>? toBoxShadow(dynamic json) {
    if (json == null) return null;

    List<BoxShadow> arr = [];
    //
    for (var value in json) {
      final boxShadow = BoxShadow(
        color: ColorUtils.tryParseColor(value["color"]),
        blurRadius:
            NumUtils.toDoubleWithNullReplacement(value["blurRadius"], 0.0),
        spreadRadius:
            NumUtils.toDoubleWithNullReplacement(value["spreadRadius"], 0.0),
        offset: toOffset(value["offset"]),
        blurStyle: toBlurStyle(value["blurStyle"]),
      );
      arr.add(boxShadow);
    }

    return arr;
  }

  /// Converts a list of values to a [Gradient].
  ///
  /// Returns a [Gradient] with the given [type] and [colors].
  /// If [type] is `null` or not a valid gradient type, or if [colors] is `null`,
  /// returns `null`.
  static Gradient? toGradient(JSONObject? json) {
    if (json == null) return null;

    final stops = json["stops"];
    final rotationAngle = json["rotationAngle"] as num?;
    final colors = json["colors"] as List?;
    final begin = toAlignment(json["begin"]);
    final end = toAlignment(json["end"]);

    final List<Color> dColors = [];

    if (colors != null) {
      for (var color in colors) {
        dColors.add(ColorUtils.tryParseColor(color));
      }
    }

    return LinearGradient(
      begin: begin,
      end: end,
      colors: dColors,
      stops: stops,
      transform: rotationAngle != null
          ? GradientRotation(rotationAngle.toDouble())
          : null,
    );
  }

  /// Converts a map of values to a [Decoration].
  ///
  /// Returns a [Decoration] with the given properties specified in the [map].
  /// If the [map] is `null` or does not contain valid properties, returns `null`.
  /// You can provide any combination of these properties in the [map].
  static Decoration? toDecoration(dynamic json) {
    if (json == null) return null;

    if (json is Decoration) return json;

    return BoxDecoration(
      color: ColorUtils.tryParseNullableColor(json["color"]),
      border: toBorder(json["border"]),
      borderRadius: json["borderRadius"] != null
          ? BorderRadius.circular(
              NumUtils.toDoubleWithNullReplacement(json["borderRadius"], 4.0))
          : null,
      shape: toBoxShape(json["shape"]),
      boxShadow: toBoxShadow(json["boxShadow"]),
      gradient: toGradient(json["gradient"]),
    );
  }

  /// Converts a map of values to a [Border].
  ///
  /// Returns a [Border] with the given properties specified in the [map].
  static Border? toBorder(dynamic json) {
    if (json == null) return null;

    if (json is Border) return json;

    return Border.fromBorderSide(
      toBorderSide(json),
    );
  }

  /// Converts a map of values to an [InputDecoration].
  ///
  /// Returns an [InputDecoration] with the given properties specified in the [map].
  static InputDecoration? toInputDecoration(JSONObject? json) {
    if (json == null) return null;

    return InputDecoration(
      labelText: json["labelText"],
      labelStyle: AttributeValueMapper.toTextStyle(json["labelStyle"]),
      floatingLabelStyle: AttributeValueMapper.toTextStyle(json["labelStyle"]),
      helperText: json["helperText"],
      helperMaxLines: json["helperMaxLines"],
      helperStyle: AttributeValueMapper.toTextStyle(json["helperStyle"]),
      hintText: json["hintText"],
      hintStyle: AttributeValueMapper.toTextStyle(json["hintStyle"]),
      hintMaxLines: json["hintMaxLines"],
      errorText: json["errorText"],
      errorMaxLines: json["errorMaxLines"],
      errorStyle: AttributeValueMapper.toTextStyle(json["errorStyle"]),
      enabledBorder: AttributeValueMapper.toInputBorder(json["enabledBorder"]),
      border: AttributeValueMapper.toInputBorder(json["border"]),
      errorBorder: AttributeValueMapper.toInputBorder(json["errorBorder"]),
      focusedBorder: AttributeValueMapper.toInputBorder(json["focusedBorder"]),
      focusedErrorBorder:
          AttributeValueMapper.toInputBorder(json["focusedErrorBorder"]),
      enabled: json["enabled"] ?? true,
      isCollapsed: json["isCollapsed"] ?? false,
      isDense: json["isDense"],
      suffixText: json["suffixText"],
      suffixStyle: AttributeValueMapper.toTextStyle(json["suffixStyle"]),
      prefixText: json["prefixText"],
      prefixStyle: AttributeValueMapper.toTextStyle(json["prefixStyle"]),
      counterText: json["counterText"],
      counterStyle: AttributeValueMapper.toTextStyle(json["prefixStyle"]),
      alignLabelWithHint: json["alignLabelWithHint"],
      filled: json["filled"],
      fillColor: ColorUtils.tryParseColor(json["fillColor"]),
      contentPadding: toEdgeInsets(json["contentPadding"]),
    );
  }

  /// Converts a string value to a [TextInputType].
  ///
  /// Returns the corresponding [TextInputType] value for the given string [value].
  /// If [value] is `null` or not a valid text input type, returns [TextInputType.text] as the default.
  static TextInputType toTextInputType(String? value) {
    if (value == null) return TextInputType.text;
    // TextInputType.
    switch (value) {
      case "text":
        return TextInputType.text;
      case "name":
        return TextInputType.name;
      case "none":
        return TextInputType.none;
      case "url":
        return TextInputType.url;
      case "emailAddress":
        return TextInputType.emailAddress;
      case "datetime":
        return TextInputType.datetime;
      case "streetAddress":
        return TextInputType.streetAddress;
      case "number":
        return TextInputType.number;
      case "phone":
        return TextInputType.phone;
      case "multiline":
        return TextInputType.multiline;
    }

    return TextInputType.text;
  }

  /// Converts a string value to a [BorderStyle].
  ///
  /// Returns the corresponding [BorderStyle] value for the given string [value].
  /// If [value] is `null` or not a valid border style, returns [BorderStyle.solid] as the default.
  static BorderStyle toBorderStyle(JSONObject? json) {
    if (json == null) return BorderStyle.solid;

    switch (json["style"]) {
      case "solid":
        return BorderStyle.solid;
      case "none":
        return BorderStyle.none;
    }

    return BorderStyle.solid;
  }

  /// Converts a string value to a [VisualDensity].
  ///
  /// Returns the corresponding [VisualDensity] value for the given string [value].
  /// If [value] is `null` or not a valid visual density, returns [VisualDensity.standard] as the default.
  static VisualDensity toVisualDensity(JSONObject? json) {
    if (json == null) return const VisualDensity();

    return VisualDensity(
      horizontal: json["horizontal"],
      vertical: json["vertical"],
    );
  }

  /// Converts a JSON string to a [MaterialStateProperty<Color>].
  ///
  /// Returns a [MaterialStateProperty<Color>] with colors based on the provided JSON string.
  /// If the [json] is `null`, returns `null`.
  /// The JSON object should contain color values for different states, such as "activeColor" and "defaultColor".
  /// You can customize the implementation to handle different states and map them to the corresponding colors.
  /// This method uses `MaterialStateProperty.resolveWith` to dynamically resolve colors based on the provided states.
  ///
  /// Example JSON string:
  /// ```
  /// {
  ///   "activeColor": 4294901760,
  ///   "defaultColor": 4278190080
  /// }
  /// ```
  ///
  /// Example usage:
  /// ```
  /// final jsonString = '{"activeColor": 4294901760, "defaultColor": 4278190080}';
  /// final mspColor = convertToMSPColor(jsonString);
  /// ```
  static WidgetStateProperty<Color>? toMSPColor(JSONObject? json) {
    if (json == null) return null;

    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return ColorUtils.tryParseColor(json[WidgetState.disabled.name]);
      }

      if (states.contains(WidgetState.selected)) {
        return ColorUtils.tryParseColor(json[WidgetState.selected.name]);
      }

      if (states.contains(WidgetState.error)) {
        return ColorUtils.tryParseColor(json[WidgetState.error.name]);
      }

      if (states.contains(WidgetState.pressed)) {
        return ColorUtils.tryParseColor(json[WidgetState.pressed.name]);
      }

      if (states.contains(WidgetState.hovered)) {
        return ColorUtils.tryParseColor(json[WidgetState.hovered.name]);
      }

      if (states.contains(WidgetState.focused)) {
        return ColorUtils.tryParseColor(json[WidgetState.focused.name]);
      }

      if (states.contains(WidgetState.dragged)) {
        return ColorUtils.tryParseColor(json[WidgetState.dragged.name]);
      }

      return Colors.black;
    });
  }

  static WidgetStateProperty<double>? toMSPDouble(JSONObject? json) {
    if (json == null) return null;

    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.disabled.name],
        );
      }

      if (states.contains(WidgetState.selected)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.selected.name],
        );
      }

      if (states.contains(WidgetState.error)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.error.name],
        );
      }

      if (states.contains(WidgetState.pressed)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.pressed.name],
        );
      }

      if (states.contains(WidgetState.hovered)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.hovered.name],
        );
      }

      if (states.contains(WidgetState.focused)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.focused.name],
        );
      }

      if (states.contains(WidgetState.dragged)) {
        return NumUtils.toDoubleWithNullReplacement(
          json[WidgetState.dragged.name],
        );
      }

      return 0;
    });
  }

  static BorderSide toBorderSide(JSONObject? json) {
    if (json == null) return BorderSide.none;

    return BorderSide(
      color: ColorUtils.tryParseColor(json["color"]),
      width: NumUtils.toDoubleWithNullReplacement(json["width"], 1.0),
      style: toBorderStyle(json["style"]),
    );
  }

  static InputBorder? toInputBorder(JSONObject? json) {
    if (json == null) return null;

    final type = json["type"] as String;
    final borderOptions = json["options"];
    final borderSide = toBorderSide(borderOptions["borderSide"]);

    switch (type) {
      case "outline":
        return OutlineInputBorder(
          borderSide: borderSide,
          gapPadding: borderOptions?["gapPadding"] ?? 4.0,
          borderRadius:
              BorderRadius.circular(borderOptions?["borderRadius"] ?? 4),
        );
      case "underline":
        return UnderlineInputBorder(
          borderSide: borderSide,
        );
    }

    return null;
  }

  //</editor-fold>

  //<editor-fold desc="Gestures">
  static ScrollViewKeyboardDismissBehavior toKeyboardDismissBehavior(
      String? value) {
    if (value == null) return ScrollViewKeyboardDismissBehavior.manual;

    switch (value) {
      case "manual":
        return ScrollViewKeyboardDismissBehavior.manual;
      case "onDrag":
        return ScrollViewKeyboardDismissBehavior.onDrag;
    }

    return ScrollViewKeyboardDismissBehavior.manual;
  }

  static ScrollPhysics toScrollPhysics(String? value) {
    if (value == null) return const AlwaysScrollableScrollPhysics();

    switch (value) {
      case "alwaysScrollableScrollPhysics":
        return const AlwaysScrollableScrollPhysics();
      case "bouncingScrollPhysics":
        return const BouncingScrollPhysics();
      case "clampingScrollPhysics":
        return const ClampingScrollPhysics();
      case "fixedExtentScrollPhysics":
        return const FixedExtentScrollPhysics();
      case "neverScrollableScrollPhysics":
        return const NeverScrollableScrollPhysics();
      //Not use this physics
      // case "PageScrollPhysics":
      //   return const PageScrollPhysics();
    }

    return const AlwaysScrollableScrollPhysics();
  }

  static DragStartBehavior toDragStartBehavior(String? behavior) {
    if (behavior == null) return DragStartBehavior.start;

    switch (behavior) {
      case "start":
        return DragStartBehavior.start;
      case "down":
        return DragStartBehavior.down;
    }

    return DragStartBehavior.start;
  }

  static HitTestBehavior toHitTestBehavior(String? behavior,
      [HitTestBehavior? defaultValue]) {
    if (behavior == null) return defaultValue ?? HitTestBehavior.deferToChild;

    switch (behavior) {
      case "deferToChild":
        return HitTestBehavior.deferToChild;
      case "opaque":
        return HitTestBehavior.opaque;
      case "translucent":
        return HitTestBehavior.translucent;
    }

    return HitTestBehavior.deferToChild;
  }

//</editor-fold>

  //<editor-fold desc="Shape and insets">

  /// Converts a JSON object to an [EdgeInsets].
  ///
  /// Returns an [EdgeInsets] with values based on the provided JSON object.
  /// If the [json] is `null` or does not contain valid properties, returns [EdgeInsets.zero] as the default.
  /// The supported properties are:
  /// - "top" (double): The top edge inset.
  /// - "right" (double): The right edge inset.
  /// - "bottom" (double): The bottom edge inset.
  /// - "left" (double): The left edge inset.
  /// You can provide any combination of these properties in the [json] object.
  ///
  /// Example JSON object:
  /// ```
  /// {
  ///   "top": 10.0,
  ///   "right": 20.0,
  ///   "bottom": 10.0,
  ///   "left": 20.0
  /// }
  /// ```
  ///
  /// Example usage:
  /// ```
  /// final json = {
  ///   "top": 10.0,
  ///   "right": 20.0,
  ///   "bottom": 10.0,
  ///   "left": 20.0
  /// };
  /// final edgeInsets = convertToEdgeInsets(json);
  /// ```
  static EdgeInsets toEdgeInsets(dynamic insets) {
    if (insets == null) return EdgeInsets.zero;

    if (insets is EdgeInsets) return insets;

    if (insets is num) {
      return EdgeInsets.all(insets.toDouble());
    }

    if (insets is List) {
      final list = List.castFrom<dynamic, num>(insets);

      if (list.length == 2) {
        return EdgeInsets.symmetric(
            vertical: insets[0].toDouble(), horizontal: insets[1].toDouble());
      }

      if (list.length == 4) {
        return EdgeInsets.only(
            left: insets[0].toDouble(),
            top: insets[1].toDouble(),
            right: insets[2].toDouble(),
            bottom: insets[3].toDouble());
      }
    }

    return EdgeInsets.zero;
  }

  static EdgeInsets? toNullableEdgeInsets(dynamic insets) {
    if (insets == null) return null;

    if (insets is num) {
      return EdgeInsets.all(insets.toDouble());
    }

    if (insets is List) {
      final list = List.castFrom<dynamic, num>(insets);

      if (list.length == 2) {
        return EdgeInsets.symmetric(
            vertical: insets[0].toDouble(), horizontal: insets[1].toDouble());
      }

      if (list.length == 4) {
        return EdgeInsets.only(
            left: insets[0].toDouble(),
            top: insets[1].toDouble(),
            right: insets[2].toDouble(),
            bottom: insets[3].toDouble());
      }
    }

    return null;
  }

//</editor-fold>

  //<editor-fold desc="Animations">
  static Curve toCurve(String? value) {
    if (value == null) return Curves.linear;

    return switch (value) {
      "linear" => Curves.linear,
      "fastEaseInToSlowEaseOut" => Curves.fastEaseInToSlowEaseOut,
      "bounceIn" => Curves.bounceIn,
      "bounceInOut" => Curves.bounceInOut,
      "bounceOut" => Curves.bounceOut,
      "decelerate" => Curves.decelerate,
      "ease" => Curves.ease,
      "easeIn" => Curves.easeIn,
      "easeInBack" => Curves.easeInBack,
      "easeInCirc" => Curves.easeInCirc,
      "easeInSine" => Curves.easeInSine,
      "easeInCubic" => Curves.easeInCubic,
      "easeInExpo" => Curves.easeInExpo,
      "easeInOutCubicEmphasized" => Curves.easeInOutCubicEmphasized,
      "easeInOutBack" => Curves.easeInOutBack,
      "easeInOutCirc" => Curves.easeInOutCirc,
      "easeInOutExpo" => Curves.easeInOutExpo,
      "easeInOutQuad" => Curves.easeInOutQuad,
      "easeInOutQuart" => Curves.easeInOutQuart,
      "easeInOutQuint" => Curves.easeInOutQuint,
      "easeInOutSine" => Curves.easeInOutSine,
      "easeInToLinear" => Curves.easeInToLinear,
      "easeOutSine" => Curves.easeOutSine,
      "easeOutBack" => Curves.easeOutBack,
      "easeOutCirc" => Curves.easeOutCirc,
      "easeOutCubic" => Curves.easeOutCubic,
      "easeOutExpo" => Curves.easeOutExpo,
      "easeOutQuad" => Curves.easeOutQuad,
      "easeOutQuart" => Curves.easeOutQuart,
      "easeOutQuint" => Curves.easeOutQuint,
      "linearToEaseOut" => Curves.linearToEaseOut,
      "slowMiddle" => Curves.slowMiddle,
      "fastOutSlowIn" => Curves.fastOutSlowIn,
      "elasticIn" => Curves.elasticIn,
      "elasticInOut" => Curves.elasticInOut,
      "elasticOut" => Curves.elasticOut,
      String() => Curves.linear,
    };
  }

  static Duration toDuration(num? value) {
    if (value == null) return Duration.zero;

    return Duration(milliseconds: value.toInt());
  }
//</editor-fold>

  static BorderRadius? toBorderRadius(JSONObject? json) {
    if (json == null) return null;

    return BorderRadius.only(
      topLeft:
          Radius.circular(NumUtils.toDouble(json['topLeft']?['radius']) ?? 0),
      topRight:
          Radius.circular(NumUtils.toDouble(json['topRight']?['radius']) ?? 0),
      bottomLeft: Radius.circular(
          NumUtils.toDouble(json['bottomLeft']?['radius']) ?? 0),
      bottomRight: Radius.circular(
          NumUtils.toDouble(json['bottomRight']?['radius']) ?? 0),
    );
  }

  static ShapeBorder? toShapeBorder(JSONObject? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == null) return null;

    switch (type) {
      case 'RoundedRectangleBorder':
        return RoundedRectangleBorder(
          borderRadius:
              toBorderRadius(json['borderRadius']) ?? BorderRadius.zero,
          side: toBorderSide(json['side']),
        );
      case 'CircleBorder':
        return CircleBorder(
          side: toBorderSide(json['side']),
        );
      case 'StadiumBorder':
        return StadiumBorder(
          side: toBorderSide(json['side']),
        );
      case 'BeveledRectangleBorder':
        return BeveledRectangleBorder(
          borderRadius:
              toBorderRadius(json['borderRadius']) ?? BorderRadius.zero,
          side: toBorderSide(json['side']),
        );
      case 'ContinuousRectangleBorder':
        return ContinuousRectangleBorder(
          borderRadius:
              toBorderRadius(json['borderRadius']) ?? BorderRadius.zero,
          side: toBorderSide(json['side']),
        );
      default:
        return null;
    }
  }

  static FloatingActionButtonLocation? toFABLocation(dynamic value) {
    if (value == null) return null;

    return switch (value) {
      "centerDocked" || 0 => FloatingActionButtonLocation.centerDocked,
      "centerFloat" || 1 => FloatingActionButtonLocation.centerFloat,
      "centerTop" || 2 => FloatingActionButtonLocation.centerTop,
      "endDocked" || 3 => FloatingActionButtonLocation.endDocked,
      "endFloat" || 4 => FloatingActionButtonLocation.endFloat,
      "endTop" || 5 => FloatingActionButtonLocation.endTop,
      "startDocked" || 6 => FloatingActionButtonLocation.startDocked,
      "startFloat" || 7 => FloatingActionButtonLocation.startFloat,
      "startTop" || 8 => FloatingActionButtonLocation.startTop,
      "miniCenterDocked" || 9 => FloatingActionButtonLocation.miniCenterDocked,
      "miniCenterFloat" || 10 => FloatingActionButtonLocation.miniCenterFloat,
      "miniCenterTop" || 11 => FloatingActionButtonLocation.miniCenterTop,
      "miniEndDocked" || 12 => FloatingActionButtonLocation.miniEndDocked,
      "miniEndFloat" || 13 => FloatingActionButtonLocation.miniEndFloat,
      "miniEndTop" || 14 => FloatingActionButtonLocation.miniEndTop,
      "miniStartDocked" || 15 => FloatingActionButtonLocation.miniStartDocked,
      "miniStartFloat" || 16 => FloatingActionButtonLocation.miniStartFloat,
      "miniStartTop" || 17 => FloatingActionButtonLocation.miniStartTop,
      _ => null,
    };
  }

  static WidgetStateProperty<TextStyle?> toWSPTextStyle(
      Map<String, dynamic> value) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return toTextStyle(value[WidgetState.disabled.name]);
      }

      if (states.contains(WidgetState.selected)) {
        return toTextStyle(value[WidgetState.selected.name]);
      }

      if (states.contains(WidgetState.error)) {
        return toTextStyle(value[WidgetState.error.name]);
      }

      if (states.contains(WidgetState.pressed)) {
        return toTextStyle(value[WidgetState.pressed.name]);
      }

      if (states.contains(WidgetState.hovered)) {
        return toTextStyle(value[WidgetState.hovered.name]);
      }

      if (states.contains(WidgetState.focused)) {
        return toTextStyle(value[WidgetState.focused.name]);
      }

      if (states.contains(WidgetState.dragged)) {
        return toTextStyle(value[WidgetState.dragged.name]);
      }

      return null;
    });
  }

  static WidgetStateProperty<T?> toWidgetStateProperty<T>(
    Map<String, dynamic> value,
  ) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.disabled.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.disabled.name],
            ),
          Size => toSize(
              value[WidgetState.disabled.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.disabled.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.disabled.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.disabled.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.disabled.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.selected)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.selected.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.selected.name],
            ),
          Size => toSize(
              value[WidgetState.selected.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.selected.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.selected.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.selected.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.selected.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.error)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.error.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.error.name],
            ),
          Size => toSize(
              value[WidgetState.error.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.error.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.error.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.error.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.error.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.pressed)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.pressed.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.pressed.name],
            ),
          Size => toSize(
              value[WidgetState.pressed.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.pressed.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.pressed.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.pressed.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.pressed.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.hovered)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.hovered.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.hovered.name],
            ),
          Size => toSize(
              value[WidgetState.hovered.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.hovered.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.hovered.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.hovered.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.hovered.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.focused)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.focused.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.focused.name],
            ),
          Size => toSize(
              value[WidgetState.focused.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.focused.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.focused.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.focused.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.focused.name],
            ),
          _ => null,
        } as T?;
      }

      if (states.contains(WidgetState.dragged)) {
        return switch (T) {
          Color => ColorUtils.tryParseNullableColor(
              value[WidgetState.dragged.name],
            ),
          EdgeInsetsGeometry => toEdgeInsets(
              value[WidgetState.dragged.name],
            ),
          Size => toSize(
              value[WidgetState.dragged.name],
            ),
          double => NumUtils.toDouble(
              value[WidgetState.dragged.name],
            ),
          OutlinedBorder => toShapeBorder(
              value[WidgetState.dragged.name],
            ),
          TextStyle => toTextStyle(
              value[WidgetState.dragged.name],
            ),
          BorderSide => toBorderSide(
              value[WidgetState.dragged.name],
            ),
          _ => null,
        } as T?;
      }

      return null;
    });
  }

  static ButtonStyle? toButtonStyle(dynamic value) {
    if (value == null) return null;

    if (value is Map) {
      final {
        "textStyle": textStyle,
        "backgroundColor": backgroundColor,
        "foregroundColor": foregroundColor,
        "overlayColor": overlayColor,
        "shadowColor": shadowColor,
        "surfaceTintColor": surfaceTintColor,
        "elevation": elevation,
        "padding": padding,
        "minimumSize": minimumSize,
        "maximumSize": maximumSize,
        "iconColor": iconColor,
        "iconSize": iconSize,
        "side": side,
        "shape": shape,
        "visualDensity": visualDensity,
        "tapTargetSize": tapTargetSize,
        "animationDuration": int? animationDuration,
        "enableFeedback": bool? enableFeedback,
        "alignment": alignment,
      } = value;

      return ButtonStyle(
        textStyle: textStyle == null
            ? null
            : toWidgetStateProperty<TextStyle>(textStyle),
        backgroundColor: backgroundColor == null
            ? null
            : toWidgetStateProperty<Color>(backgroundColor),
        foregroundColor: foregroundColor == null
            ? null
            : toWidgetStateProperty<Color>(foregroundColor),
        overlayColor: overlayColor == null
            ? null
            : toWidgetStateProperty<Color>(overlayColor),
        shadowColor: shadowColor == null
            ? null
            : toWidgetStateProperty<Color>(shadowColor),
        surfaceTintColor: surfaceTintColor == null
            ? null
            : toWidgetStateProperty<Color>(surfaceTintColor),
        elevation:
            elevation == null ? null : toWidgetStateProperty<double>(elevation),
        padding: padding == null
            ? null
            : toWidgetStateProperty<EdgeInsetsGeometry>(padding),
        minimumSize: minimumSize == null
            ? null
            : toWidgetStateProperty<Size>(minimumSize),
        maximumSize: maximumSize == null
            ? null
            : toWidgetStateProperty<Size>(maximumSize),
        iconColor:
            iconColor == null ? null : toWidgetStateProperty<Color>(iconColor),
        iconSize:
            iconSize == null ? null : toWidgetStateProperty<double>(iconSize),
        side: side == null ? null : toWidgetStateProperty<BorderSide>(side),
        shape:
            shape == null ? null : toWidgetStateProperty<OutlinedBorder>(shape),
        visualDensity: toVisualDensity(visualDensity),
        tapTargetSize: toMaterialTapTargetSize(tapTargetSize),
        animationDuration:
            animationDuration == null ? null : toDuration(animationDuration),
        enableFeedback: enableFeedback,
        alignment: toAlignment(alignment),
      );
    }
    return null;
  }

  /// Converts a string value to a [CollapseMode] value.
  ///
  /// Returns the corresponding [CollapseMode] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  static CollapseMode toCollapseMode(String? value) {
    if (value == null) return CollapseMode.parallax;

    switch (value) {
      case "parallax":
        return CollapseMode.parallax;
      case "pin":
        return CollapseMode.pin;
      case "none":
        return CollapseMode.none;
    }

    return CollapseMode.parallax;
  }

  /// Converts a list of string values to a list of [StretchMode] values.
  ///
  /// Returns the corresponding list of [StretchMode] values for the given list of strings [value].
  /// If [value] is `null`, returns `null`.
  static List<StretchMode> toStretchModes(List<String>? value) {
    if (value == null) return const [StretchMode.zoomBackground];

    final stretchModes = <StretchMode>[];
    for (final item in value) {
      stretchModes.add(toStretchMode(item));
    }

    return stretchModes.isNotEmpty
        ? stretchModes
        : const [StretchMode.zoomBackground];
  }

  /// Converts a string value to a [StretchMode] value.
  ///
  /// Returns the corresponding [StretchMode] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  static StretchMode toStretchMode(String? value) {
    if (value == null) return StretchMode.zoomBackground;

    switch (value) {
      case "zoomBackground":
        return StretchMode.zoomBackground;
      case "blurBackground":
        return StretchMode.blurBackground;
      case "fadeTitle":
        return StretchMode.fadeTitle;
    }

    return StretchMode.zoomBackground;
  }
}
