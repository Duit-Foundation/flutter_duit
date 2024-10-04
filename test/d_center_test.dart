import "package:alchemist/alchemist.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget([bool? controlled = false]) {
  return {
    "type": "Center",
    "id": "centerId",
    "controlled": controlled,
    "attributes": {
      "widthFactor": 1.5,
      "heightFactor": 0.5,
    },
    "child": {
      "type": "Container",
      "id": "con",
      "controlled": false,
      "attributes": {
        "color": "#DCDCDC",
        "width": 50,
        "height": 50,
      },
    }
  };
}

void main() {
  group("DuitCenter widget tests", () {
    const dim = 100.0;

    goldenTest("DuitCenter base variants", fileName: "d_center_base",
        builder: () {
      return GoldenTestScenario(
        name: "Center",
        child: SizedBox.square(
          dimension: dim,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );
    });

    final driver = DuitDriver.static(
      _createWidget(true),
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );

    goldenTest(
      "DuitCenter update",
      fileName: "d_center_upd",
      pumpBeforeTest: (t) async {
        await t.pumpAndSettle();
        await driver.updateTestAttributes(
          "centerId",
          {
            "widthFactor": 0.5,
            "heightFactor": 1.5,
          },
        );
        await t.pumpAndSettle();
      },
      builder: () {
        return GoldenTestScenario(
          name: "Center",
          child: SizedBox.square(
            dimension: dim,
            child: DuitViewHost(
              driver: driver,
            ),
          ),
        );
      },
    );

    testWidgets("DuitAlign key assignment", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final widget = find.byKey(
        const ValueKey("centerId"),
      );

      expect(widget, findsOneWidget);
    });
  });
}
