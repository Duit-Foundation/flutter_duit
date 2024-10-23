import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_test/flutter_test.dart";

///Create widget templates for testing
const _uncText = {
  "type": "Text",
  "id": "text",
  "controlled": false,
  "attributes": {
    "data": "Hello, World!",
    "style": {
      "color": "#DCDCDC",
      "fontSize": 14.0,
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
    testWidgets("check simple render scenario", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _uncText,
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Hello, World!"), findsOneWidget);
    });

    testWidgets("check text layout without data prop", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _uncTextWithoutData,
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets("check text update process", (tester) async {
      final driver = DuitDriver.static(
        _cTextWithoutData,
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

      expect(find.text("Good bye, World!"), findsOneWidget);

      await driver.updateTestAttributes("1", {
        "data": "Hello, World!",
        "style": {
          "color": "#DCDCDC",
          "fontSize": 14.0,
          "fontWeight": 700,
        }
      });

      await tester.pumpAndSettle();

      expect(find.text("Hello, World!"), findsOneWidget);
    });

    testWidgets("check animation", (tester) async {
      final driver = DuitDriver.static(
        _textWithPropAnimation,
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

      final text = find.byKey(const Key("1")).evaluate().single.widget as Text?;

      final fSize = text?.style?.fontSize;
      final fWeight = text?.style?.fontWeight;

      expect(fSize, 24.0);
      expect(fWeight, FontWeight.w700);
    });

    testWidgets("check widget key assignment", (tester) async {
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

    testWidgets("check update when data prop is empty or null", (tester) async {
      final driver = DuitDriver.static(
        _cTextWithoutData,
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

      final text = find.text("Good bye, World!");
      expect(text, findsOneWidget);

      await driver.updateTestAttributes("1", {});

      await tester.pumpAndSettle();

      expect(text, findsOneWidget);
    });

    test("check attributes", () async {
      final attrs = TextAttributes(
        data: "",
        parentBuilderId: null,
        affectedProperties: null,
      );

      expect(() => attrs.dispatchInternalCall("invalid"), throwsUnimplementedError);
    });
  });
}
