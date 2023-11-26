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

  //</editor-fold>

  //<editor-fold desc="Basic">
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
