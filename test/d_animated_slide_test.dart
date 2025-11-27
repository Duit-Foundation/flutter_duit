import 'package:flutter/material.dart' show AnimatedSlide, ValueKey, Container;
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('DuitAnimatedSlide', () {
    testWidgets(
      "DuitAnimatedSlide must renders correctly",
      (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Stack",
            "id": "stack",
            "controlled": false,
            "attributes": <String, dynamic>{},
            "children": [
              {
                "type": "AnimatedSlide",
                "id": "slide",
                "attributes": {
                  "offset": {"dx": 0.5, "dy": 0.0},
                  "duration": 100,
                },
                "child": {
                  "type": "Text",
                  "id": "text",
                  "attributes": {
                    "data": "Some text",
                  },
                },
              },
            ],
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(find.byKey(const ValueKey("slide")), findsOneWidget);
        expect(find.byType(AnimatedSlide), findsOneWidget);
        expect(find.text("Some text"), findsOneWidget);
      },
    );

    testWidgets(
      "DuitAnimatedSlide must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedSlide",
            "id": "slide",
            "controlled": true,
            "attributes": {
              "offset": {"dx": 0.0, "dy": 0.0},
              "duration": 100,
            },
            "child": {
              "type": "Text",
              "id": "text",
              "attributes": {
                "data": "Some text",
              },
            }
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(find.byKey(const ValueKey("slide")), findsOneWidget);
        expect(find.text("Some text"), findsOneWidget);

        // Update the offset
        await driver.updateAttributes("slide", {
          "offset": {"dx": 0.5, "dy": 0.0},
        });

        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey("slide")), findsOneWidget);
        expect(find.text("Some text"), findsOneWidget);
      },
    );

    testWidgets(
      "DuitAnimatedSlide must call onEnd callback",
      (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedSlide",
            "id": "slide",
            "controlled": true,
            "attributes": {
              "offset": {"dx": 0.0, "dy": 0.0},
              "duration": 100,
              "onEnd": {
                "executionType": 1, //local
                "event": "local_exec",
                "payload": {
                  "type": "update",
                  "updates": {
                    "text": {
                      "data": "ANIMATION_ENDED",
                    },
                  }
                },
              },
            },
            "child": {
              "type": "Text",
              "id": "text",
              "controlled": true,
              "attributes": {
                "data": "Some text",
              },
            }
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(find.text("Some text"), findsOneWidget);

        // Update the offset to trigger animation
        await driver.updateAttributes("slide", {
          "offset": {"dx": 0.5, "dy": 0.0},
        });

        // Wait for animation to complete
        await tester.pumpAndSettle();

        // Check that onEnd callback was called and text was updated
        expect(find.text("ANIMATION_ENDED"), findsOneWidget);
      },
    );

    testWidgets(
      "DuitAnimatedSlide must handle different offset values",
      (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedSlide",
            "id": "slide",
            "controlled": true,
            "attributes": {
              "offset": {"dx": 0.0, "dy": 0.0},
              "duration": 100,
            },
            "child": {
              "type": "Container",
              "id": "container",
              "attributes": {
                "width": 50,
                "height": 50,
                "color": "#FF0000",
              },
            }
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(find.byKey(const ValueKey("slide")), findsOneWidget);

        // Test different offset combinations
        final testOffsets = [
          {"dx": 0.5, "dy": 0.0}, // Right
          {"dx": -0.5, "dy": 0.0}, // Left
          {"dx": 0.0, "dy": 0.5}, // Down
          {"dx": 0.0, "dy": -0.5}, // Up
          {"dx": 0.5, "dy": 0.5}, // Diagonal
        ];

        for (final offset in testOffsets) {
          await driver.updateAttributes("slide", {
            "offset": offset,
          });

          await tester.pumpAndSettle();

          expect(find.byKey(const ValueKey("slide")), findsOneWidget);
          expect(find.byType(Container), findsOneWidget);
        }
      },
    );

    testWidgets(
      "DuitAnimatedSlide must handle different curves",
      (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "AnimatedSlide",
            "id": "slide",
            "controlled": true,
            "attributes": {
              "offset": {"dx": 0.0, "dy": 0.0},
              "duration": 100,
              "curve": "linear",
            },
            "child": {
              "type": "Text",
              "id": "text",
              "attributes": {
                "data": "Test text",
              },
            }
          },
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(
          tester,
          driver,
        );

        expect(find.byKey(const ValueKey("slide")), findsOneWidget);
        expect(find.text("Test text"), findsOneWidget);

        // Test different curves
        final testCurves = ["ease", "bounceIn", "bounceOut"];

        for (final curve in testCurves) {
          await driver.updateAttributes("slide", {
            "offset": {"dx": 0.5, "dy": 0.0},
            "curve": curve,
          });

          await tester.pumpAndSettle();

          expect(find.byKey(const ValueKey("slide")), findsOneWidget);
          expect(find.text("Test text"), findsOneWidget);
        }
      },
    );
  });
}
