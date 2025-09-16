import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitAnimatedPhysicalModel widget tests",
    () {
      testWidgets("must render correctly", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedPhysicalModel",
            "id": "animated_physical_model",
            "attributes": {
              "duration": 300,
              "curve": "ease",
              "elevation": 4.0,
              "color": [255, 0, 0, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "antiAlias",
            },
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 100,
                "height": 100,
              },
            },
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(
          tester.widget(
            find.byKey(
              const ValueKey("animated_physical_model"),
            ),
          ),
          isA<AnimatedPhysicalModel>(),
        );
        expect(
          find.byKey(const ValueKey("animated_physical_model")),
          findsOneWidget,
        );
      });

      testWidgets("must animate elevation change", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedPhysicalModel",
            "id": "animated_physical_model",
            "attributes": {
              "duration": 200,
              "curve": "linear",
              "elevation": 2.0,
              "color": [0, 255, 0, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "hardEdge",
            },
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 80,
                "height": 80,
              },
            },
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        final animatedPhysicalModel =
            find.byKey(const ValueKey("animated_physical_model"));
        expect(animatedPhysicalModel, findsOneWidget);

        final widget =
            tester.widget<AnimatedPhysicalModel>(animatedPhysicalModel);
        expect(widget.elevation, 2.0);
        expect(widget.duration, const Duration(milliseconds: 200));
        expect(widget.curve, Curves.linear);
        expect(widget.color, const Color.fromARGB(255, 0, 255, 0));
        expect(widget.shadowColor, Colors.black);
        expect(widget.clipBehavior, Clip.hardEdge);
      });

      testWidgets("must handle borderRadius", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedPhysicalModel",
            "id": "animated_physical_model",
            "attributes": {
              "duration": 150,
              "elevation": 6.0,
              "color": [0, 0, 255, 1],
              "shadowColor": [128, 128, 128, 1],
              "clipBehavior": "antiAlias",
              "borderRadius": {
                "topLeft": <String, dynamic>{"radius": 20.0},
                "topRight": <String, dynamic>{"radius": 20.0},
                "bottomLeft": <String, dynamic>{"radius": 20.0},
                "bottomRight": <String, dynamic>{"radius": 20.0},
              },
            },
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 120,
                "height": 120,
              },
            },
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        final animatedPhysicalModel =
            find.byKey(const ValueKey("animated_physical_model"));
        expect(animatedPhysicalModel, findsOneWidget);

        final widget =
            tester.widget<AnimatedPhysicalModel>(animatedPhysicalModel);
        expect(widget.elevation, 6.0);
        expect(widget.duration, const Duration(milliseconds: 150));
        expect(widget.color, const Color.fromARGB(255, 0, 0, 255));
        expect(widget.shadowColor, const Color.fromARGB(255, 128, 128, 128));
        expect(widget.clipBehavior, Clip.antiAlias);
        expect(
          widget.borderRadius,
          const BorderRadius.all(Radius.circular(20)),
        );
      });

      testWidgets("must handle onEnd callback", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedPhysicalModel",
            "id": "animated_physical_model",
            "attributes": {
              "duration": 100,
              "curve": "easeIn",
              "elevation": 3.0,
              "color": [255, 255, 0, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "none",
              "onEnd": {"type": "action", "action": "test_action"},
            },
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 60,
                "height": 60,
              },
            },
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        final animatedPhysicalModel =
            find.byKey(const ValueKey("animated_physical_model"));
        expect(animatedPhysicalModel, findsOneWidget);

        final widget =
            tester.widget<AnimatedPhysicalModel>(animatedPhysicalModel);
        expect(widget.elevation, 3.0);
        expect(widget.duration, const Duration(milliseconds: 100));
        expect(widget.curve, Curves.easeIn);
        expect(widget.color, const Color.fromARGB(255, 255, 255, 0));
        expect(widget.clipBehavior, Clip.none);
        expect(widget.onEnd, isNotNull);
      });
    },
  );
}
