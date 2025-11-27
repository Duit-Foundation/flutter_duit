import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "IntrinsicWidth",
    "id": "intrinsicWidthId",
    "controlled": isControlled,
    "attributes": {
      "stepWidth": 10.0,
    },
    "child": {
      "type": "Container",
      "id": "conId",
      "controlled": false,
      "attributes": {
        "color": "#075eeb",
      },
    },
  };
}

void main() {
  group("DuitIntrinsicWidth widget tests", () {
    testWidgets("check widget", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: EmptyTransportOptions(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey("intrinsicWidthId"));

      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(true),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        var widget = find.byKey(const ValueKey("intrinsicWidthId"));
        expect(widget, findsOneWidget);

        await driver.updateAttributes(
          "intrinsicWidthId",
          {
            "stepWidth": 12.0,
          },
        );

        await tester.pumpAndSettle();

        widget = find.byKey(const ValueKey("intrinsicWidthId"));
        final intrW = tester.widget<IntrinsicWidth>(widget);
        expect(intrW.stepWidth, 12.0);
      },
    );
  });
}
