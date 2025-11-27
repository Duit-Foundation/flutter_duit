import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

Map<String, dynamic> _createWidget(
    {bool isControlled = false, int? childIndex}) {
  return {
    "type": "RepaintBoundary",
    "id": "repaintBoundaryId",
    "controlled": isControlled,
    "attributes": {
      if (childIndex != null) "childIndex": childIndex,
    },
    "child": {
      "type": "Container",
      "id": "conId",
      "controlled": false,
      "attributes": {
        "color": "#075eeb",
      },
    }
  };
}

void main() {
  group("DuitRepaintBoundary widget tests", () {
    testWidgets("check widget", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(),
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);

      final repaintBoundaries = find.byType(RepaintBoundary);
      expect(repaintBoundaries, findsWidgets);
      expect(
          tester.widgetList(repaintBoundaries).length, greaterThanOrEqualTo(1));
    });

    testWidgets(
      "controlled widget renders and updates childIndex",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(isControlled: true),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        final widget = find.byKey(const ValueKey("repaintBoundaryId"));
        expect(widget, findsOneWidget);

        await driver.updateAttributes(
          "repaintBoundaryId",
          {
            "childIndex": 0,
          },
        );

        await tester.pumpAndSettle();

        final repaintBoundaries = find.byType(RepaintBoundary);
        expect(repaintBoundaries, findsWidgets);
        expect(tester.widgetList(repaintBoundaries).length,
            greaterThanOrEqualTo(1));
      },
    );
  });
}
