import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

class ParamsMapper {
  static TextAlign? convertToTextAlign(String value) {
    switch (value) {
      case "left":
        TextAlign.left;
      case "right":
        TextAlign.right;
      case "center":
        TextAlign.center;
      case "justify":
        TextAlign.justify;
      case "end":
        TextAlign.end;
      case "start":
        TextAlign.start;
    }

    return null;
  }

  static FontWeight? convertToFontWeight(int value) {
    switch (value) {
      case 100:
        FontWeight.w100;
      case 200:
        FontWeight.w200;
      case 300:
        FontWeight.w300;
      case 400:
        FontWeight.w400;
      case 500:
        FontWeight.w500;
      case 600:
        FontWeight.w600;
      case 700:
        FontWeight.w700;
      case 800:
        FontWeight.w800;
      case 900:
        FontWeight.w900;
    }

    return null;
  }

  static TextOverflow? convertToTextOverflow(String value) {
    switch (value) {
      case "fade":
        TextOverflow.fade;
      case "ellipsis":
        TextOverflow.ellipsis;
      case "clip":
        TextOverflow.clip;
      case "visible":
        TextOverflow.visible;
    }

    return null;
  }

  static TextStyle convertToTextStyle(JSONObject json) {
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

  static TextDirection? convertToTextDirection(String value) {
    switch (value) {
      case "rtl":
        TextDirection.rtl;
      case "ltr":
        TextDirection.ltr;
    }

    return null;
  }
}
