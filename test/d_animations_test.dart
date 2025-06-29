import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_test/flutter_test.dart';

final groupTween = {
  "type": "group",
  "tweens": [
    {
      "type": "tween",
      "begin": 100.0,
      "end": 200.0,
      "curve": "linear",
      "duration": 500,
      "trigger": 0,
      "method": 0,
      "animatedPropKey": "width",
      "reverseOnRepeat": false,
      "interval": [0.0, 0.5],
    },
    {
      "type": "tween",
      "begin": 100.0,
      "end": 200.0,
      "curve": "linear",
      "duration": 100,
      "trigger": 0,
      "method": 0,
      "animatedPropKey": "height",
      "reverseOnRepeat": false,
      "interval": [0.5, 1.0],
    }
  ],
  "curve": "linear",
  "duration": 500,
  "trigger": 0,
  "method": 0,
  "groupId": "group",
};

final colorTween = {
  "type": "colorTween",
  "begin": "#000000",
  "end": "#FFFFFF",
  "curve": "linear",
  "duration": 100,
  "trigger": 0,
  "method": 0,
  "animatedPropKey": "val",
  "reverseOnRepeat": false,
  "interval": {"begin": 0.0, "end": 1.0},
};

final baseTween = {
  "type": "tween",
  "begin": "0",
  "end": "1",
  "curve": "linear",
  "duration": 100,
  "trigger": 0,
  "method": 0,
  "animatedPropKey": "width",
  "reverseOnRepeat": false,
  "interval": [0.0, 1.0],
};

final textStyleTween = {
  "type": "textStyleTween",
  "animatedPropKey": "style",
  "begin": {"fontSize": 8.0, "fontWeight": 200, "color": "#075eeb"},
  "end": {"fontSize": 24.0, "fontWeight": 700, "color": "#03fcc2"},
  "duration": 100,
  "curve": "linear",
  "trigger": 0,
  "method": 3,
  "reverseOnRepeat": false,
};

final decorationTween = {
  "type": "decorationTween",
  "begin": {"color": "#075eeb"},
  "end": {"color": "#03fcc2"},
  "duration": 100,
  "curve": "linear",
  "trigger": 0,
  "method": 2,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

final alignmentTween = {
  "type": "alignmentTween",
  "begin": "topCenter",
  "end": "bottomRight",
  "duration": 100,
  "curve": "linear",
  "trigger": 0,
  "method": 0,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

final edgeInsetsTween = {
  "type": "edgeInsetsTween",
  "begin": 8,
  "end": 16,
  "duration": 100,
  "curve": "linear",
  "trigger": 0,
  "method": 0,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

final boxConstraintsTween = {
  "type": "boxConstraintsTween",
  "begin": {},
  "end": {},
  "duration": 100,
  "curve": "linear",
  "trigger": 1,
  "method": 0,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

final sizeTween = {
  "type": "sizeTween",
  "begin": {
    "width": 100,
    "height": 100,
  },
  "end": {
    "width": 200,
    "height": 250,
  },
  "duration": 100,
  "curve": "linear",
  "trigger": 2,
  "method": 1,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

final borderTween = {
  "type": "borderTween",
  "begin": {
    "color": "#DCDCDC",
  },
  "end": {
    "color": "#075eeb",
  },
  "duration": 100,
  "curve": "linear",
  "trigger": null,
  "method": null,
  "animatedPropKey": "style",
  "reverseOnRepeat": false,
};

void main() {
  group(
    "Duit animations tests",
    () {
      test("test tween creation", () {
        final tweenTypes = [
          groupTween,
          baseTween,
          colorTween,
          textStyleTween,
          decorationTween,
          alignmentTween,
          edgeInsetsTween,
          boxConstraintsTween,
          sizeTween,
          borderTween
        ];

        const tweenObjTypes = <Type>[
          TweenDescriptionGroup,
          TweenDescription,
          ColorTweenDescription,
          TextStyleTweenDescription,
          DecorationTweenDescription,
          AlignmentTweenDescription,
          EdgeInsetsTweenDescription,
          BoxConstraintsTweenDescription,
          SizeTweenDescription,
          BorderTweenDescription
        ];

        for (int i = 0; i < tweenTypes.length; i++) {
          final tweenType = tweenTypes[i];
          final tweenObjType = tweenObjTypes[i];

          final tween = DuitTweenDescription.fromJson(tweenType);

          expect(tween.runtimeType, tweenObjType);
        }

        final invalidTween = {"type": "invalid"};

        expect(
          () => DuitTweenDescription.fromJson(invalidTween),
          throwsUnimplementedError,
        );
      });

      test("test TweenDescriptionGroup parsing and structure", () {
        final group = DuitTweenDescription.fromJson(groupTween);
        expect(group, isA<TweenDescriptionGroup>());

        final groupCasted = group as TweenDescriptionGroup;

        expect(groupCasted.groupId, 'group');
        expect(groupCasted.tweens.length, 2);
        expect(groupCasted.tweens.first, isA<TweenDescription>());
        expect(groupCasted.tweens.first.animatedPropKey, 'width');
        expect(groupCasted.tweens.last.animatedPropKey, 'height');
        expect(groupCasted.duration, const Duration(milliseconds: 500));
        expect(groupCasted.method.index, 0);
        expect(groupCasted.trigger.index, 0);
      });
    },
  );
}
