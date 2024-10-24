import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget([bool controlled = false, int turns = 0]) {
  return {
    "controlled": controlled,
    "id": "r1",
    "type": "RotatedBox",
    "attributes": {
      "quarterTurns": turns,
    },
    "child": {
      "controlled": false,
      "id": "c1",
      "type": "Container",
      "attributes": {
        "color": "#DCDCDC",
        "width": 200,
        "height": 100,
      },
    }
  };
}

void main() {
  group("DuitRotatedBox test", () {
    testWidgets("check widget stateless variant", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(false, 1),
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

      final RenderBox box =
      tester.renderObject(find.byKey(const ValueKey("c1")));

      await tester.pumpAndSettle();

      expect(box.size, equals(const Size(600, 800)));
    });

    testWidgets("check rotation", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(true),
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

      final RenderBox box =
          tester.renderObject(find.byKey(const ValueKey("c1")));

      expect(box.size, equals(const Size(800, 600)));

      await driver.updateTestAttributes("r1", {
        "quarterTurns": 1,
      });

      await tester.pumpAndSettle();

      expect(box.size, equals(const Size(600, 800)));
    });
  });
}
