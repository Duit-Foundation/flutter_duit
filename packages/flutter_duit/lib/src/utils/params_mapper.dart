import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

extension ParamsMapper on dynamic {
  TextAlign? toTextAlign() {
    switch (this) {
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

  FontWeight? toFontWeight() {
    switch (this) {
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

  TextOverflow? toTextOverflow() {
    switch (this) {
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

  TextStyle toTextStyle() {
    return TextStyle(
      color: ColorUtils.tryParseColor(this["color"]),
      fontFamily: this["fontFamily"],
      fontWeight: this["fontWeight"].toFontWeight(),
      fontSize: this["fontSize"],
      letterSpacing: this["letterSpacing"],
      wordSpacing: this["wordSpacing"],
      height: this["height"],
    );
  }

  TextDirection? toTextDirection() {
    switch (this) {
      case "rtl":
        TextDirection.rtl;
      case "ltr":
        TextDirection.ltr;
    }

    return null;
  }
}
