import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";
import "package:golden_toolkit/golden_toolkit.dart";

///Create widget templates for testing
const _uncText = {
  "type": "Text",
  "id": "text",
  "controlled": false,
  "attributes": {
    "data": "Hello, World!",
    "style": {
      "fontSize": 24.0,
      "fontWeight": 700,
    }
  },
};

const _uncTextWithoutData = {
  "type": "Text",
  "id": "1",
  "controlled": false,
  "attributes": {
    "data": null,
    "style": {
      "fontSize": 24.0,
      "fontWeight": 700,
    }
  },
};

const _cTextWithoutData = {
  "type": "Text",
  "id": "1",
  "controlled": true,
  "attributes": {
    "data": "Good bye, World!",
    "style": {
      "fontSize": 12.0,
      "fontWeight": 200,
    }
  },
};

const _textWithPropAnimation = {
  "type": "AnimatedBuilder",
  "id": "builder",
  "controlled": true,
  "attributes": {
    "tweenDescriptions": [
      {
        "type": "textStyleTween",
        "animatedPropKey": "style",
        "duration": 1000,
        "begin": {"fontSize": 8.0, "fontWeight": 200, "color": "#075eeb"},
        "end": {"fontSize": 24.0, "fontWeight": 700, "color": "#03fcc2"},
        "curve": "linear",
        "trigger": 0,
        "method": 1,
        "reverseOnRepeat": true,
      }
    ],
  },
  "child": {
    "type": "Text",
    "id": "1",
    "controlled": false,
    "attributes": {
      "data": "Good bye, World!",
      "parentBuilderId": "builder",
      "affectedProperties": {"style"},
    },
  }
};

void main() {
  group("DuitText widget tests", () {
    testGoldens("Uncontrolled DuitText", (tester) async {
      final builder = GoldenBuilder.column();
      builder
        ..addScenarioBuilder(
          "Simple text",
          (context) {
            final driver = DuitDriver.static(
              _uncText,
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            );

            return DuitViewHost(
              driver: driver,
              // context: context,
            );
          },
        )
        ..addScenarioBuilder(
          "Text without data",
          (context) {
            final driver = DuitDriver.static(
              _uncTextWithoutData,
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            );

            return DuitViewHost(
              driver: driver,
              context: context,
            );
          },
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
      );

      await screenMatchesGolden(
        tester,
        "d_text",
        autoHeight: true,
      );
    });

    testGoldens("Controlled DuitText", (tester) async {
      final driver = DuitDriver.static(
        _cTextWithoutData,
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );

      final builder = GoldenBuilder.column();

      builder.addScenarioBuilder("Update process", (context) {
        return DuitViewHost(
          driver: driver,
          context: context,
        );
      });

      await tester.pumpWidgetBuilder(
        builder.build(),
      );

      await screenMatchesGolden(
        tester,
        "d_c_text_before",
        autoHeight: true,
      );

      await driver.updateTestAttributes("1", {
        "data": "Hello, World!",
        "style": {
          "fontSize": 24.0,
          "fontWeight": 700,
          "color": "#03fcc2",
        }
      });

      await tester.pumpAndSettle();

      await screenMatchesGolden(
        tester,
        "d_c_text_after",
        autoHeight: true,
      );
    });

    testWidgets("DuitText props animations", (tester) async {
      final AnimationSheetBuilder animationSheet = AnimationSheetBuilder(
        frameSize: const Size(100, 100),
      );
      addTearDown(animationSheet.dispose);

      final driver = DuitDriver.static(
        _textWithPropAnimation,
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );

      final widget = Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(driver: driver),
        ),
      );

      await tester.pumpFrames(
        animationSheet.record(widget),
        const Duration(milliseconds: 1000),
      );

      await expectLater(
        animationSheet.collate(10),
        matchesGoldenFile("goldens/d_text_animation.png"),
      );
    });

    testWidgets("Widget key assignment", (tester) async {
      final driver = DuitDriver.static(
        _uncText,
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final text = find.byKey(const Key("text"));
      expect(text, findsOneWidget);
    });
  });
}
