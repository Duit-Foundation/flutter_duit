import "package:alchemist/alchemist.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

///Create widget templates for testing
const _uncText = {
  "type": "Text",
  "id": "text",
  "controlled": false,
  "attributes": {
    "data": "Hello, World!",
    "style": {
      "color": "#075eeb",
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
        "duration": 100,
        "begin": {"fontSize": 8.0, "fontWeight": 200, "color": "#075eeb"},
        "end": {"fontSize": 24.0, "fontWeight": 700, "color": "#03fcc2"},
        "curve": "linear",
        "trigger": 0,
        "method": 0,
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
  group("DuitText widget", () {
    goldenTest(
      "Uncontrolled DuitText",
      fileName: "d_text",
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: "Simple text",
            child: DuitViewHost(
              driver: DuitDriver.static(
                _uncText,
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "Text without data",
            child: DuitViewHost(
              driver: DuitDriver.static(
                _uncTextWithoutData,
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              ),
            ),
          )
        ],
      ),
    );

    goldenTest(
      "Controlled DuitText before update",
      fileName: "d_c_text_before",
      builder: () {
        final driver = DuitDriver.static(
          _cTextWithoutData,
          transportOptions: HttpTransportOptions(),
          enableDevMetrics: false,
        );

        return GoldenTestScenario(
          name: "Before update",
          child: DuitViewHost(
            driver: driver,
          ),
        );
      },
    );

    final uDriver = DuitDriver.static(
      _cTextWithoutData,
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );

    goldenTest(
      "Controlled DuitText after update",
      fileName: "d_c_text_after",
      pumpBeforeTest: (t) async {
        await uDriver.updateTestAttributes("1", {
          "data": "Hello, World!",
          "style": {
            "fontSize": 24.0,
            "fontWeight": 700,
            "color": "#03fcc2",
          }
        });

        await t.pumpAndSettle(const Duration(seconds: 3));
      },
      builder: () {
        return GoldenTestScenario(
          name: "After update",
          child: DuitViewHost(
            driver: uDriver,
          ),
        );
      },
    );

    final aDriver = DuitDriver.static(
      _textWithPropAnimation,
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );

    goldenTest(
      "DuitText props animation",
      fileName: "d_text_animation",
      pumpBeforeTest: (t) async {
        await t.pumpAndSettle(
          const Duration(milliseconds: 500),
        );
      },
      builder: () {
        return GoldenTestScenario(
          name: "Animation end",
          child: DuitViewHost(
            driver: aDriver,
          ),
        );
      },
    );

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
