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
    },
  };
}

void main() {
  group("DuitCenter widget tests", () {
    testWidgets("check center", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(true),
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            key: const ValueKey("box"),
            width: 1000,
            height: 1000,
            child: DuitViewHost(
              driver: driver,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await driver.updateAttributes("centerId", {
        "widthFactor": 0.5,
        "heightFactor": 1.5,
      });

      await tester.pumpAndSettle();

      final box = find.byKey(const ValueKey("box"));

      expect(box, findsOneWidget);

      final center = tester.getCenter(box);

      final cont = tester.getCenter(find.byKey(const ValueKey("con")));

      expect(center, equals(cont));

      final cWidget =
          tester.widget(find.byKey(const ValueKey("centerId"))) as Center;

      expect(cWidget.widthFactor, 0.5);
      expect(cWidget.heightFactor, 1.5);
    });

    testWidgets("check widget key assignment", (tester) async {
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

      final widget = find.byKey(
        const ValueKey("centerId"),
      );

      expect(widget, findsOneWidget);
    });
  });
}
