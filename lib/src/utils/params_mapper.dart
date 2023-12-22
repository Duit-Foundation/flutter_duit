import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A utility class for mapping parameter values to their corresponding Flutter widget properties.
class ParamsMapper {
  //<editor-fold desc="Text">

  /// Converts a string value to a [TextAlign] value.
  ///
  /// Returns the corresponding [TextAlign] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  static TextAlign? convertToTextAlign(String? value) {
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

  /// Converts an integer value to a [FontWeight] value.
  ///
  /// Returns the corresponding [FontWeight] value for the given integer [value].
  /// If [value] is `null`, returns `null`.
  static FontWeight? convertToFontWeight(int? value) {
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
  static TextOverflow? convertToTextOverflow(String? value) {
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
  static TextStyle? convertToTextStyle(JSONObject? json) {
    if (json == null) return null;

    final size = json["fontSize"] as num?;

    return TextStyle(
      color: ColorUtils.tryParseColor(json["color"]),
      fontFamily: json["fontFamily"],
      fontWeight: convertToFontWeight(json["fontWeight"]),
      fontSize: size?.toDouble(),
      letterSpacing: json["letterSpacing"],
      wordSpacing: json["wordSpacing"],
      height: json["height"],
    );
  }

  /// Converts a string value to a [TextDirection] value.
  ///
  /// Returns the corresponding [TextDirection] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid text direction, returns [TextDirection.ltr] as the default.
  static TextDirection? convertToTextDirection(String? value) {
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
  static BoxConstraints? convertToBoxConstraints(JSONObject? json) {
    if (json == null) return null;

    return BoxConstraints(
      minWidth: NumUtils.toDoubleWithNullReplacement(json["minWidth"], 0.0),
      maxWidth: NumUtils.toDoubleWithNullReplacement(
          json["maxWidth"], double.infinity),
      minHeight: NumUtils.toDoubleWithNullReplacement(json["minHeight"], 0.0),
      maxHeight: NumUtils.toDoubleWithNullReplacement(
          json["maxHeight"], double.infinity),
    );
  }

  /// Converts a string value to a [StackFit] value.
  ///
  /// Returns the corresponding [StackFit] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid stack fit, returns [StackFit.loose] as the default.
  static StackFit convertToStackFit(String? value) {
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

  /// Converts a string value to an [Alignment] value.
  ///
  /// Returns the corresponding [Alignment] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid alignment, returns [Alignment.center] as the default.
  static AlignmentGeometry convertToAlignment(String? value) {
    if (value == null) return Alignment.topLeft;

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

    return Alignment.topLeft;
  }

  /// Converts a string value to an [AlignmentDirectional] value.
  ///
  /// Returns the corresponding [AlignmentDirectional] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid alignment, returns [AlignmentDirectional.centerStart] as the default.
  static AlignmentGeometry convertToAlignmentDirectional(String? value) {
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
  static MainAxisAlignment? convertToMainAxisAlignment(String? value) {
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
  static CrossAxisAlignment? convertToCrossAxisAlignment(String? value) {
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
  static Clip? convertToClip(String? value) {
    if (value == null) return null;

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

    return null;
  }

  /// Converts a string value to a [MainAxisSize] value.
  ///
  /// Returns the corresponding [MainAxisSize] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid main axis size, returns [MainAxisSize.max] as the default.
  static MainAxisSize? convertToMainAxisSize(String? value) {
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

  /// Converts a string value to a [FilterQuality] value.
  ///
  /// Returns the corresponding [FilterQuality] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid filter quality, returns [FilterQuality.low] as the default.
  static FilterQuality convertToFilterQuality(String? value) {
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

// Converts a string value to an [ImageRepeat] value.
  ///
  /// Returns the corresponding [ImageRepeat] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid image repeat value, returns [ImageRepeat.noRepeat] as the default.
  static ImageRepeat convertToImageRepeat(String? value) {
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
  static Uint8List convertToUint8List(dynamic value) {
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
  static ImageType convertToImageType(String? value) {
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
  static BoxFit? convertToBoxFit(String? value) {
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
  static BlendMode convertToBlendMode(String? value) {
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

  /// Converts a string value to a [VerticalDirection] value.
  ///
  /// Returns the corresponding [VerticalDirection] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid vertical direction, returns [VerticalDirection.down] as the default.
  static VerticalDirection? convertToVerticalDirection(String? value) {
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
  static BoxShape convertToBoxShape(String? value) {
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
  static Offset convertToOffset(JSONObject? json) {
    if (json == null) return Offset.zero;

    return Offset(json["dx"] ?? 0.0, json["dy"] ?? 0.0);
  }

  /// Converts a string value to a [BlurStyle] value.
  ///
  /// Returns the corresponding [BlurStyle] value for the given string [value].
  /// If [value] is `null`, returns `null`.
  /// If [value] is not a valid blur style, returns [BlurStyle.normal] as the default.
  static BlurStyle convertToBlurStyle(String? value) {
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
  static List<BoxShadow>? convertToBoxShadow(dynamic json) {
    if (json == null) return null;

    List<BoxShadow> arr = [];
    //
    for (var value in json) {
      final boxShadow = BoxShadow(
        color: ColorUtils.tryParseColor(value["color"]),
        blurRadius: value["blurRadius"],
        spreadRadius: value["spreadRadius"],
        offset: convertToOffset(value["offset"]),
        blurStyle: convertToBlurStyle(value["blurStyle"]),
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
  static Gradient? convertToGradient(JSONObject? json) {
    if (json == null) return null;

    final stops = json["stops"];
    final rotationAngle = json["rotationAngle"] as num?;
    final colors = json["colors"] as List?;
    final begin = convertToAlignment(json["begin"]);
    final end = convertToAlignment(json["end"]);

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
  static Decoration? convertToDecoration(JSONObject? json) {
    if (json == null) return null;

    return BoxDecoration(
      color: ColorUtils.tryParseNullableColor(json["color"]),
      border: convertToBorder(json["border"]),
      borderRadius: json["borderRadius"] != null
          ? BorderRadius.circular(
              NumUtils.toDoubleWithNullReplacement(json["borderRadius"], 4.0))
          : null,
      shape: convertToBoxShape(json["shape"]),
      boxShadow: convertToBoxShadow(json["boxShadow"]),
      gradient: convertToGradient(json["gradient"]),
    );
  }

  /// Converts a map of values to a [Border].
  ///
  /// Returns a [Border] with the given properties specified in the [map].
  static Border? convertToBorder(JSONObject? json) {
    if (json == null) return null;

    return Border.fromBorderSide(
      convertToBorderSide(json),
    );
  }

  /// Converts a map of values to an [InputDecoration].
  ///
  /// Returns an [InputDecoration] with the given properties specified in the [map].
  static InputDecoration? convertToInputDecoration(JSONObject? json) {
    if (json == null) return null;

    return InputDecoration(
      labelText: json["labelText"],
      labelStyle: ParamsMapper.convertToTextStyle(json["labelStyle"]),
      floatingLabelStyle: ParamsMapper.convertToTextStyle(json["labelStyle"]),
      helperText: json["helperText"],
      helperMaxLines: json["helperMaxLines"],
      helperStyle: ParamsMapper.convertToTextStyle(json["helperStyle"]),
      hintText: json["hintText"],
      hintStyle: ParamsMapper.convertToTextStyle(json["hintStyle"]),
      hintMaxLines: json["hintMaxLines"],
      errorText: json["errorText"],
      errorMaxLines: json["errorMaxLines"],
      errorStyle: ParamsMapper.convertToTextStyle(json["errorStyle"]),
      enabledBorder: ParamsMapper.convertToInputBorder(json["enabledBorder"]),
      border: ParamsMapper.convertToInputBorder(json["border"]),
      errorBorder: ParamsMapper.convertToInputBorder(json["errorBorder"]),
      focusedBorder: ParamsMapper.convertToInputBorder(json["focusedBorder"]),
      focusedErrorBorder:
          ParamsMapper.convertToInputBorder(json["focusedErrorBorder"]),
      enabled: json["enabled"] ?? true,
      isCollapsed: json["isCollapsed"] ?? false,
      isDense: json["isDense"],
      suffixText: json["suffixText"],
      suffixStyle: ParamsMapper.convertToTextStyle(json["suffixStyle"]),
      prefixText: json["prefixText"],
      prefixStyle: ParamsMapper.convertToTextStyle(json["prefixStyle"]),
      counterText: json["counterText"],
      counterStyle: ParamsMapper.convertToTextStyle(json["prefixStyle"]),
      alignLabelWithHint: json["alignLabelWithHint"],
      filled: json["filled"],
      fillColor: ColorUtils.tryParseColor(json["fillColor"]),
      contentPadding: convertToEdgeInsets(json["contentPadding"]),
    );
  }

  /// Converts a string value to a [TextInputType].
  ///
  /// Returns the corresponding [TextInputType] value for the given string [value].
  /// If [value] is `null` or not a valid text input type, returns [TextInputType.text] as the default.
  static TextInputType convertToTextInputType(String? value) {
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
  static BorderStyle convertToBorderStyle(JSONObject? json) {
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
  static VisualDensity convertToVisualDensity(JSONObject? json) {
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
  static MaterialStateProperty<Color>? convertToMSPColor(JSONObject? json) {
    if (json == null) return null;

    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return ColorUtils.tryParseColor(json[MaterialState.disabled.name]);
      }

      if (states.contains(MaterialState.selected)) {
        return ColorUtils.tryParseColor(json[MaterialState.selected.name]);
      }

      if (states.contains(MaterialState.error)) {
        return ColorUtils.tryParseColor(json[MaterialState.error.name]);
      }

      if (states.contains(MaterialState.pressed)) {
        return ColorUtils.tryParseColor(json[MaterialState.pressed.name]);
      }

      if (states.contains(MaterialState.hovered)) {
        return ColorUtils.tryParseColor(json[MaterialState.hovered.name]);
      }

      if (states.contains(MaterialState.focused)) {
        return ColorUtils.tryParseColor(json[MaterialState.focused.name]);
      }

      if (states.contains(MaterialState.dragged)) {
        return ColorUtils.tryParseColor(json[MaterialState.dragged.name]);
      }

      return Colors.black;
    });
  }

  static BorderSide convertToBorderSide(JSONObject? json) {
    if (json == null) return BorderSide.none;

    return BorderSide(
      color: ColorUtils.tryParseColor(json["color"]),
      width: NumUtils.toDoubleWithNullReplacement(json["width"], 1.0),
      style: convertToBorderStyle(json["style"]),
    );
  }

  static InputBorder? convertToInputBorder(JSONObject? json) {
    if (json == null) return null;

    final type = json["type"] as String;
    final borderOptions = json["options"];
    final borderSide = convertToBorderSide(borderOptions["borderSide"]);

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
  static DragStartBehavior convertToDragStartBehavior(String? behavior) {
    if (behavior == null) return DragStartBehavior.start;

    switch (behavior) {
      case "start":
        return DragStartBehavior.start;
      case "down":
        return DragStartBehavior.down;
    }

    return DragStartBehavior.start;
  }

  static HitTestBehavior convertToHitTestBehavior(String? behavior) {
    if (behavior == null) return HitTestBehavior.deferToChild;

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
  static EdgeInsets convertToEdgeInsets(dynamic insets) {
    if (insets == null) return EdgeInsets.zero;

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

//</editor-fold>
}
