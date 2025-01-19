import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'tween.dart';

extension type _TweenView(Map<String, dynamic> value) implements Map {
  AnimationMethod get method {
    final val = value["method"];
    return switch (val) {
      0 || "forvard" => AnimationMethod.forward,
      1 || "repeat" => AnimationMethod.repeat,
      2 || "reverse" => AnimationMethod.reverse,
      3 || "toggle" => AnimationMethod.toggle,
      Object() || null => AnimationMethod.forward,
    };
  }

  AnimationInterval? get interval {
    final interval = value["interval"];
    if (interval == null) {
      return null;
    }

    if (interval is Map) {
      return AnimationInterval(
        NumUtils.toDoubleWithNullReplacement(interval["begin"], 0.0),
        NumUtils.toDoubleWithNullReplacement(interval["end"], 1.0),
      );
    }

    if (interval is List) {
      return AnimationInterval(
        interval[0],
        interval[1],
      );
    }

    return null;
  }

  AnimationTrigger get trigger {
    final trigger = value["trigger"];
    return switch (trigger) {
      0 || "onEnter" => AnimationTrigger.onEnter,
      1 || "onAction" => AnimationTrigger.onAction,
      Object() || null => AnimationTrigger.onEnter,
    };
  }
}

/// Base class for describing a Tween object, parsing json into concrete Tween types
base class DuitTweenDescription<T> {
  final String animatedPropKey;
  final Duration duration;
  final T begin, end;
  final Curve curve;
  final AnimationTrigger trigger;
  final AnimationMethod method;
  final bool reverseOnRepeat;
  final AnimationInterval? interval;

  const DuitTweenDescription({
    required this.animatedPropKey,
    required this.duration,
    required this.begin,
    required this.end,
    this.trigger = AnimationTrigger.onEnter,
    this.curve = Curves.linear,
    this.method = AnimationMethod.forward,
    this.reverseOnRepeat = false,
    this.interval,
  });

  /// Deserializes a [json] object into a [DuitTweenDescription]
  static DuitTweenDescription fromJson(JSONObject json) {
    final type = json["type"] as String;

    final view = _TweenView(json);

    if (type == "group") {
      assert(json.containsKey("tweens"),
          "Group object must have **tweens** property");
      assert(json["tweens"] is List,
          "Group object **tweens** property must be a list");

      return TweenDescriptionGroup(
        duration: AttributeValueMapper.toDuration(json["duration"]),
        groupId: json["groupId"],
        tweens: (json["tweens"] as List)
            .cast<Map<String, dynamic>>()
            .map((tween) => DuitTweenDescription.fromJson(tween))
            .toList(),
        method: view.method,
        reverseOnRepeat: json["reverseOnRepeat"] ?? false,
        trigger: view.trigger,
      );
    }

    return switch (type) {
      "colorTween" => ColorTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: ColorUtils.tryParseColor(json["begin"]),
          end: ColorUtils.tryParseColor(json["end"]),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "tween" => TweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: NumUtils.toDoubleWithNullReplacement(json["begin"], 0.0),
          end: NumUtils.toDoubleWithNullReplacement(json["end"], 0.0),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "textStyleTween" => TextStyleTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toTextStyle(json["begin"])!,
          end: AttributeValueMapper.toTextStyle(json["end"])!,
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "decorationTween" => DecorationTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toDecoration(json["begin"])!,
          end: AttributeValueMapper.toDecoration(json["end"])!,
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "alignmentTween" => AlignmentTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toAlignment(json["begin"]),
          end: AttributeValueMapper.toAlignment(json["end"]),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "edgeInsetsTween" => EdgeInsetsTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toEdgeInsets(json["begin"]),
          end: AttributeValueMapper.toEdgeInsets(json["end"]),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "boxConstraintsTween" => BoxConstraintsTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toBoxConstraints(json["begin"]),
          end: AttributeValueMapper.toBoxConstraints(json["end"]),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "sizeTween" => SizeTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toSize(json["begin"]),
          end: AttributeValueMapper.toSize(json["end"]),
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      "borderTween" => BorderTweenDescription(
          animatedPropKey: json["animatedPropKey"],
          duration: AttributeValueMapper.toDuration(json["duration"]),
          begin: AttributeValueMapper.toBorder(json["begin"])!,
          end: AttributeValueMapper.toBorder(json["end"])!,
          curve: AttributeValueMapper.toCurve(json["curve"]),
          trigger: view.trigger,
          method: view.method,
          reverseOnRepeat: json["reverseOnRepeat"] ?? false,
          interval: view.interval,
        ),
      String() => throw UnimplementedError(),
    };
  }
}
