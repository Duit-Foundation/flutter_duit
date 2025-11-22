import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _buildWrapper(
  Map<String, dynamic> child,
  List<DuitTweenDescription> dcs,
) {
  return {
    "type": "AnimatedBuilder",
    "id": "builder",
    "controlled": true,
    "attributes": {
      "tweenDescriptions": dcs,
    },
    "child": child,
  };
}

void main() {
  testWidgets(
    "ColorTweenDescription",
    (tester) async {
      final dsc = ColorTweenDescription(
        animatedPropKey: "color",
        duration: const Duration(milliseconds: 10),
        begin: Colors.black,
        end: Colors.white,
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Container",
            "id": "con",
            "attributes": <String, dynamic>{
              "width": 25,
              "height": 25,
              "parentBuilderId": "builder",
              "affectedProperties": {
                "color",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Container>(
        find.byKey(
          const ValueKey("con"),
        ),
      );
      expect(
        widget.color,
        Colors.white,
      );
    },
  );
  testWidgets(
    "TweenDescription",
    (tester) async {
      final dsc = TweenDescription(
        animatedPropKey: "width",
        duration: const Duration(milliseconds: 10),
        begin: 25.0,
        end: 100.0,
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "SizedBox",
            "id": "con",
            "attributes": <String, dynamic>{
              "width": 25,
              "height": 25,
              "parentBuilderId": "builder",
              "affectedProperties": {
                "width",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<SizedBox>(
        find.byKey(
          const ValueKey("con"),
        ),
      );

      expect(widget.width, 100);
    },
  );
  testWidgets(
    "TextStyleTweenDescription",
    (tester) async {
      final dsc = TextStyleTweenDescription(
        animatedPropKey: "style",
        duration: const Duration(milliseconds: 10),
        begin: const TextStyle(
          color: Colors.black,
        ),
        end: const TextStyle(
          color: Colors.red,
        ),
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Text",
            "id": "con",
            "attributes": <String, dynamic>{
              "data": "Text",
              "parentBuilderId": "builder",
              "affectedProperties": {
                "style",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Text>(
        find.byKey(
          const ValueKey("con"),
        ),
      );
      expect(
        widget.style,
        const TextStyle(
          color: Colors.red,
        ),
      );
    },
  );
  testWidgets(
    "DecorationTweenDescription",
    (tester) async {
      final dsc = DecorationTweenDescription(
        animatedPropKey: "decoration",
        duration: const Duration(milliseconds: 10),
        begin: const BoxDecoration(
          color: Colors.black,
        ),
        end: const BoxDecoration(
          color: Colors.red,
        ),
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Container",
            "id": "con",
            "attributes": <String, dynamic>{
              "width": 25,
              "height": 25,
              "parentBuilderId": "builder",
              "affectedProperties": {
                "decoration",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Container>(
        find.byKey(
          const ValueKey("con"),
        ),
      );
      expect(
        widget.decoration,
        const BoxDecoration(
          color: Colors.red,
        ),
      );
    },
  );
  testWidgets(
    "AlignmentTweenDescription",
    (tester) async {
      final dsc = AlignmentTweenDescription(
        animatedPropKey: "alignment",
        duration: const Duration(milliseconds: 10),
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Align",
            "id": "con",
            "attributes": <String, dynamic>{
              "parentBuilderId": "builder",
              "affectedProperties": {
                "alignment",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Align>(
        find.byKey(
          const ValueKey("con"),
        ),
      );
      expect(
        widget.alignment,
        Alignment.topLeft,
      );
    },
  );
  testWidgets(
    "EdgeInsetsTweenDescription",
    (tester) async {
      final dsc = EdgeInsetsTweenDescription(
        animatedPropKey: "padding",
        duration: const Duration(milliseconds: 10),
        begin: EdgeInsets.zero,
        end: const EdgeInsets.all(24),
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Container",
            "id": "con",
            "attributes": <String, dynamic>{
              "width": 25,
              "height": 25,
              "parentBuilderId": "builder",
              "affectedProperties": {
                "padding",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Container>(
        find.byKey(
          const ValueKey("con"),
        ),
      );
      expect(
        widget.padding,
        const EdgeInsets.all(24),
      );
    },
  );
  testWidgets(
    "BoxConstraintsTweenDescription",
    (tester) async {
      final dsc = BoxConstraintsTweenDescription(
        animatedPropKey: "constraints",
        duration: const Duration(milliseconds: 10),
        begin: const BoxConstraints(
          maxHeight: 100,
          minHeight: 25,
          maxWidth: 50,
          minWidth: 25,
        ),
        end: const BoxConstraints(),
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Container",
            "id": "con",
            "attributes": <String, dynamic>{
              "parentBuilderId": "builder",
              "affectedProperties": {
                "constraints",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Container>(
        find.byKey(
          const ValueKey("con"),
        ),
      );

      expect(
        widget.constraints,
        const BoxConstraints(),
      );
    },
  );
  testWidgets(
    "SizeTweenDescription",
    (tester) async {
      final dsc = BoxConstraintsTweenDescription(
        animatedPropKey: "constraints",
        duration: const Duration(milliseconds: 10),
        begin: const BoxConstraints(
          maxHeight: 100,
          minHeight: 25,
          maxWidth: 50,
          minWidth: 25,
        ),
        end: const BoxConstraints(),
        curve: Curves.linear,
        trigger: AnimationTrigger.onEnter,
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "Container",
            "id": "con",
            "attributes": <String, dynamic>{
              "parentBuilderId": "builder",
              "affectedProperties": {
                "constraints",
              },
            },
          },
          [dsc],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<Container>(
        find.byKey(
          const ValueKey("con"),
        ),
      );

      expect(
        widget.constraints,
        const BoxConstraints(),
      );
    },
  );

  testWidgets(
    "TweenGroup",
    (tester) async {
      final group = TweenDescriptionGroup(
        duration: const Duration(milliseconds: 10),
        groupId: "",
        tweens: [
          TweenDescription(
            animatedPropKey: "width",
            duration: Duration.zero,
            begin: 25.0,
            end: 100.0,
            curve: Curves.linear,
            trigger: AnimationTrigger.onEnter,
            method: AnimationMethod.forward,
            reverseOnRepeat: false,
            interval: const AnimationInterval(0, 0.5),
          ),
          TweenDescription(
            animatedPropKey: "height",
            duration: Duration.zero,
            begin: 25.0,
            end: 100.0,
            curve: Curves.linear,
            trigger: AnimationTrigger.onEnter,
            method: AnimationMethod.forward,
            reverseOnRepeat: false,
            interval: const AnimationInterval(0.5, 1.0),
          ),
        ],
        method: AnimationMethod.forward,
        reverseOnRepeat: false,
        trigger: AnimationTrigger.onEnter,
      );

      final driver = DuitDriver.static(
        _buildWrapper(
          {
            "type": "SizedBox",
            "id": "con",
            "attributes": <String, dynamic>{
              "parentBuilderId": "builder",
              "affectedProperties": {
                "width",
                "height",
              },
            },
          },
          [
            group,
          ],
        ),
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final widget = tester.widget<SizedBox>(
        find.byKey(
          const ValueKey("con"),
        ),
      );

      expect(
        widget.width,
        100,
      );

      expect(
        widget.height,
        100,
      );
    },
  );

  group(
    "Animation commands",
    () {
      testWidgets(
        "Toggle test",
        (tester) async {
          final dsc = TweenDescription(
            animatedPropKey: "width",
            duration: const Duration(milliseconds: 10),
            begin: 25.0,
            end: 100.0,
            curve: Curves.linear,
            trigger: AnimationTrigger.onAction,
            method: AnimationMethod.toggle,
            reverseOnRepeat: false,
          );

          final driver = DuitDriver.static(
            _buildWrapper(
              {
                "type": "SizedBox",
                "id": "con",
                "attributes": <String, dynamic>{
                  "parentBuilderId": "builder",
                  "affectedProperties": {
                    "width",
                  },
                },
              },
              [dsc],
            ),
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          var widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 25);

          final action = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "builder",
                "commandData": {
                  "type": "animation",
                  "animatedPropKey": "width",
                  "trigger": 1,
                  "method": 3,
                },
              },
            },
          );

          await driver.execute(action);
          await tester.pumpAndSettle();

          widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 100);

          await driver.execute(action);
          await tester.pumpAndSettle();

          widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 25);
        },
      );

      testWidgets(
        "Reverse test",
        (tester) async {
          final dsc = TweenDescription(
            animatedPropKey: "width",
            duration: const Duration(milliseconds: 10),
            begin: 25.0,
            end: 100.0,
            curve: Curves.linear,
            trigger: AnimationTrigger.onEnter,
            method: AnimationMethod.forward,
            reverseOnRepeat: false,
          );

          final driver = DuitDriver.static(
            _buildWrapper(
              {
                "type": "SizedBox",
                "id": "con",
                "attributes": <String, dynamic>{
                  "parentBuilderId": "builder",
                  "affectedProperties": {
                    "width",
                  },
                },
              },
              [dsc],
            ),
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          var widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 100);

          final reverseAction = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "builder",
                "commandData": {
                  "type": "animation",
                  "animatedPropKey": "width",
                  "trigger": 1,
                  "method": 2,
                },
              },
            },
          );

          await driver.execute(reverseAction);
          await tester.pumpAndSettle();

          widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 25);
        },
      );

      testWidgets(
        "Repeat test",
        (tester) async {
          final dsc = TweenDescription(
            animatedPropKey: "width",
            duration: const Duration(milliseconds: 10),
            begin: 25.0,
            end: 100.0,
            curve: Curves.linear,
            trigger: AnimationTrigger.onEnter,
            method: AnimationMethod.forward,
            reverseOnRepeat: false,
          );

          final driver = DuitDriver.static(
            _buildWrapper(
              {
                "type": "SizedBox",
                "id": "con",
                "attributes": <String, dynamic>{
                  "parentBuilderId": "builder",
                  "affectedProperties": {
                    "width",
                  },
                },
              },
              [dsc],
            ),
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          var widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 100);

          final repeatAction = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "builder",
                "commandData": {
                  "type": "animation",
                  "animatedPropKey": "width",
                  "trigger": 1,
                  "method": 1,
                },
              },
            },
          );

          await driver.execute(repeatAction);
          await tester.pump();

          widget = tester.widget<SizedBox>(
            find.byKey(
              const ValueKey("con"),
            ),
          );

          expect(widget.width, 100);
        },
      );
    },
  );
}
