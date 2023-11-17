import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class ParamsMapper {
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

    return TextStyle(
      color: ColorUtils.tryParseColor(json["color"]),
      fontFamily: json["fontFamily"],
      fontWeight: convertToFontWeight(json["fontWeight"]),
      fontSize: json["fontSize"],
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
}
