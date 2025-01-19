import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _builder(
  List<Map<String, dynamic>> tweens, {
  Set<String>? props,
}) =>
    {
      "type": "AnimatedBuilder",
      "id": "builder",
      "controlled": true,
      "attributes": {
        "tweenDescriptions": tweens,
      },
      "child": {
        "type": "SizedBox",
        "id": "container",
        "controlled": false,
        "attributes": {
          "parentBuilderId": "builder",
          "affectedProperties": props,
        },
      }
    };

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

      group(
        "Animation launch tests",
        () {
          testWidgets(
            "test FORWARD method",
            (t) async {
              final driver = DuitDriver.static(
                _builder([groupTween], props: {"height"}),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              );

              await t.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: DuitViewHost(
                    driver: driver,
                  ),
                ),
              );

              await t.pumpAndSettle();

              final animationTarget = find.byKey(const ValueKey("container"));

              expect(animationTarget, findsOneWidget);

              var container =
                  animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 200);
              expect(container.width, null);
            },
          );

          testWidgets(
            "test TOGGLE method",
            (t) async {
              // groupTween["trigger"] = 01;

              final driver = DuitDriver.static(
                _builder([groupTween], props: {"height"}),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              );

              await t.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: DuitViewHost(
                    driver: driver,
                  ),
                ),
              );

              await t.pumpAndSettle();

              final animationTarget = find.byKey(const ValueKey("container"));

              expect(animationTarget, findsOneWidget);

              var container =
                  animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 200);
              expect(container.width, null);
            },
          );
        },
      );

      group(
        "Animation commands tests",
        () {
          testWidgets(
            "test FORWARD animation command",
            (t) async {
              groupTween["trigger"] = 1;

              final driver = DuitDriver.static(
                _builder([groupTween], props: {"height"}),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              );

              await t.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: DuitViewHost(
                    driver: driver,
                  ),
                ),
              );

              await t.pumpAndSettle();

              final animationTarget = find.byKey(const ValueKey("container"));
              var container =
                  animationTarget.evaluate().first.widget as SizedBox;

              expect(animationTarget, findsOneWidget);
              expect(container.height, equals(100));

              await driver.executeTestAction(
                LocalAction.fromJson(
                  {
                    "payload": {
                      "type": "animationTrigger",
                      "method": 0,
                      "animatedPropKey": "group",
                      "controllerId": "builder",
                    }
                  },
                ),
              );

              await t.pumpAndSettle();

              container = animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 200);
            },
          );

          testWidgets(
            "test REVERSE animation command",
            (t) async {
              final driver = DuitDriver.static(
                _builder([groupTween], props: {"height"}),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              );

              await t.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: DuitViewHost(
                    driver: driver,
                  ),
                ),
              );

              await t.pumpAndSettle();

              final animationTarget = find.byKey(const ValueKey("container"));
              var container =
                  animationTarget.evaluate().first.widget as SizedBox;

              expect(animationTarget, findsOneWidget);
              expect(container.height, equals(100));

              await driver.executeTestAction(
                LocalAction.fromJson(
                  {
                    "payload": {
                      "type": "animationTrigger",
                      "method": 2,
                      "animatedPropKey": "group",
                      "controllerId": "builder",
                    }
                  },
                ),
              );

              await t.pumpAndSettle();

              container = animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 100);
            },
          );

          testWidgets(
            "test TOGGLE animation command",
            (t) async {
              groupTween["trigger"] = 1;

              final driver = DuitDriver.static(
                _builder([groupTween], props: {"height"}),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              );

              await t.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: DuitViewHost(
                    driver: driver,
                  ),
                ),
              );

              await t.pumpAndSettle();

              final animationTarget = find.byKey(const ValueKey("container"));
              var container =
                  animationTarget.evaluate().first.widget as SizedBox;

              expect(animationTarget, findsOneWidget);
              expect(container.height, equals(100));

              await driver.executeTestAction(
                LocalAction.fromJson(
                  {
                    "payload": {
                      "type": "animationTrigger",
                      "method": 3,
                      "animatedPropKey": "group",
                      "controllerId": "builder",
                    }
                  },
                ),
              );

              await t.pumpAndSettle();

              container = animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 200);

              await driver.executeTestAction(
                LocalAction.fromJson(
                  {
                    "payload": {
                      "type": "animationTrigger",
                      "method": 3,
                      "animatedPropKey": "group",
                      "controllerId": "builder",
                    }
                  },
                ),
              );

              await t.pumpAndSettle();

              container = animationTarget.evaluate().first.widget as SizedBox;

              expect(container.height, 100);
            },
          );
        },
      );
    },
  );
}
