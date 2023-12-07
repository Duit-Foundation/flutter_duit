import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class ParamsMapper {
  //<editor-fold desc="Text">
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

  static Clip convertToClip(String? value) {
    if (value == null) return Clip.hardEdge;

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

    return Clip.hardEdge;
  }

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

  static Uint8List convertToUint8List(dynamic value) {
    if (value == null) return Uint8List(0);

    if (value is Uint8List) {
      return value;
    }

    if (value is List<int>) {
      return Uint8List.fromList(value);
    }

    return Uint8List(0);
  }

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

  static Offset convertToOffset(JSONObject? json) {
    if (json == null) return Offset.zero;

    return Offset(json["dx"] ?? 0.0, json["dy"] ?? 0.0);
  }

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

  static List<BoxShadow>? convertToBoxShadow(JSONObject? json) {
    if (json == null) return null;

    List<BoxShadow> arr = [];

    json.forEach((key, value) {
      final shadow = value as Map<String, dynamic>;
      final boxShadow = BoxShadow(
        color: ColorUtils.tryParseColor(shadow["color"]),
        blurRadius: shadow["blurRadius"],
        spreadRadius: shadow["spreadRadius"],
        offset: convertToOffset(json["offset"]),
        blurStyle: convertToBlurStyle(shadow["blurStyle"]),
      );
      arr.add(boxShadow);
    });

    return arr;
  }

  static Gradient? convertToGradient(JSONObject? json) {
    if (json == null) return null;

    final stops = json["stops"];
    final rotationAngle = json["rotationAngle"] as num?;
    final colors = json["colors"];
    final begin = json["begin"] ?? Alignment.centerLeft;
    final end = json["end"] ?? Alignment.centerRight;

    final List<Color> dColors = [];

    if (colors != null) {
      colors.forEach((_, value) {
        dColors.add(ColorUtils.tryParseColor(value));
      });
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

  static Decoration? convertToDecoration(JSONObject? json) {
    if (json == null) return null;

    return BoxDecoration(
      color: ColorUtils.tryParseColor(json["color"]),
      border: convertToBorder(json["border"]),
      borderRadius: BorderRadius.circular(json["borderRadius"] ?? 4),
      shape: convertToBoxShape(json["shape"]),
      boxShadow: convertToBoxShadow(json["boxShadow"]),
      gradient: convertToGradient(json["gradient"]),
    );
  }

  static Border? convertToBorder(JSONObject? json) {
    if (json == null) return null;

    return Border.fromBorderSide(
      convertToBorderSide(json),
    );
  }

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

  static convertToBorderStyle(JSONObject? json) {
    if (json == null) return BorderStyle.solid;

    switch (json["style"]) {
      case "solid":
        return BorderStyle.solid;
      case "none":
        return BorderStyle.none;
    }
  }

  static VisualDensity convertToVisualDensity(JSONObject? json) {
    if (json == null) return const VisualDensity();

    return VisualDensity(
      horizontal: json["horizontal"],
      vertical: json["vertical"],
    );
  }

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

    final width = json["width"] as num?;

    return BorderSide(
      color: ColorUtils.tryParseColor(json["color"]),
      width: width?.toDouble() ?? 1.0,
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

  //<editor-fold desc="Shape and insets">
  static EdgeInsets convertToEdgeInsets(dynamic insets) {
    if (insets == null) return EdgeInsets.zero;

    if (insets is num) {
      return EdgeInsets.all(insets.toDouble());
    }

    if (insets is List<num>) {
      if (insets.length == 2) {
        return EdgeInsets.symmetric(
            vertical: insets[0].toDouble(), horizontal: insets[1].toDouble());
      }

      if (insets.length == 4) {
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
