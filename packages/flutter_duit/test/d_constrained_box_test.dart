import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget(
  BoxConstraints value, [
  bool? controlled = false,
]) {
  return {
    "type": "ConstrainedBox",
    "id": "constraint",
    "controlled": controlled,
    "attributes": {
      "constraints": {
        "minWidth": value.minWidth,
        "minHeight": value.minHeight,
        "maxWidth": value.maxWidth,
        "maxHeight": value.maxHeight,
      },
    },
    "child": {
      "type": "Container",
      "id": "container",
      "controlled": false,
      "attributes": {
        "width": 1000,
        "height": 100,
      },
    },
  };
}

void main() {
  group("ConstrainedBox tests", () {
    testWidgets("check constraints works", (tester) async {
      final driver = XDriver.static(
        _createWidget(
          const BoxConstraints(
            maxHeight: 500,
            maxWidth: 500,
            minHeight: 200,
            minWidth: 100,
          ),
        ),
      );

      await tester.pumpWidget(
        Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: driver,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final container = find.byKey(const Key("container"));
      final containerSize = tester.getSize(container);
      expect(containerSize.width, equals(500));
      expect(containerSize.height, equals(200));
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = XDriver.static(
          _createWidget(
            const BoxConstraints(
              maxHeight: 500,
              maxWidth: 500,
              minHeight: 200,
              minWidth: 100,
            ),
            true,
          ),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final constrBoxFinder = find.byKey(const ValueKey("constraint"));
        expect(constrBoxFinder, findsOneWidget);

        await driver.asInternalDriver.updateAttributes("constraint", {
          "constraints": {
            "minWidth": 100,
            "minHeight": 100,
            "maxWidth": 200,
            "maxHeight": 200,
          },
        });

        await tester.pumpAndSettle();

        final constrBoxWidget = tester
            .widget<ConstrainedBox>(find.byKey(const ValueKey("constraint")));

        expect(
          constrBoxWidget.constraints,
          const BoxConstraints(
            minHeight: 100,
            minWidth: 100,
            maxHeight: 200,
            maxWidth: 200,
          ),
        );
      },
    );
  });
}
