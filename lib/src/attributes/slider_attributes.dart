import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliderAttributes extends AttendedModel<double>
    implements DuitAttributes<SliderAttributes> {
  final double? min, max, secondaryTrackValue;
  final int? divisions;
  final String? label;
  final Color? activeColor, inactiveColor, secondaryActiveColor, thumbColor;
  final MaterialStateProperty<Color>? overlayColor;
  final bool autofocus;
  final ServerAction? onChanged, onChangeStart, onChangeEnd;
  final SliderInteraction? allowedInteraction;

  SliderAttributes({
    required super.value,
    this.min,
    this.max,
    this.secondaryTrackValue,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.secondaryActiveColor,
    this.thumbColor,
    this.overlayColor,
    this.autofocus = false,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.allowedInteraction,
  });

  factory SliderAttributes.fromJson(Map<String, dynamic> json) {
    return SliderAttributes(
      value: NumUtils.toDoubleWithNullReplacement(json["value"], 0.0),
      secondaryTrackValue: NumUtils.toDouble(json["secondaryTrackValue"]),
      min: NumUtils.toDoubleWithNullReplacement(json["min"], 0.0),
      max: NumUtils.toDoubleWithNullReplacement(json["max"], 1.0),
      divisions: NumUtils.toInt(json['divisions']),
      label: json['label'],
      activeColor: ColorUtils.tryParseNullableColor(json['activeColor']),
      inactiveColor: ColorUtils.tryParseNullableColor(json['inactiveColor']),
      secondaryActiveColor:
          ColorUtils.tryParseNullableColor(json['secondaryActiveColor']),
      thumbColor: ColorUtils.tryParseNullableColor(json['thumbColor']),
      overlayColor: AttributeValueMapper.toMSPColor(json['overlayColor']),
      autofocus: json['autofocus'] ?? false,
      onChanged: json['onChanged'] != null
          ? ServerAction.parse(json['onChanged'])
          : null,
      onChangeStart: json['onChangeStart'] != null
          ? ServerAction.parse(json['onChangeStart'])
          : null,
      onChangeEnd: json['onChangeEnd'] != null
          ? ServerAction.parse(json['onChangeEnd'])
          : null,
      allowedInteraction:
          AttributeValueMapper.toSliderInteraction(json["allowedInteraction"]),
    );
  }

  @override
  SliderAttributes copyWith(SliderAttributes other) {
    return SliderAttributes(
      value: other.value,
      min: other.min ?? min,
      max: other.max ?? max,
      divisions: other.divisions ?? divisions,
      label: other.label ?? label,
      activeColor: other.activeColor ?? activeColor,
      inactiveColor: other.inactiveColor ?? inactiveColor,
      secondaryActiveColor: other.secondaryActiveColor ?? secondaryActiveColor,
      thumbColor: other.thumbColor ?? thumbColor,
      overlayColor: other.overlayColor ?? overlayColor,
      autofocus: other.autofocus,
      onChanged: other.onChanged ?? onChanged,
      onChangeStart: other.onChangeStart ?? onChangeStart,
      onChangeEnd: other.onChangeEnd ?? onChangeEnd,
      allowedInteraction: other.allowedInteraction ?? allowedInteraction,
      secondaryTrackValue: other.secondaryTrackValue ?? secondaryTrackValue,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        SliderAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
