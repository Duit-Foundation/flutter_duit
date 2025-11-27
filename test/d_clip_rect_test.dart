import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitClipRect tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "ClipRect",
              "id": "clipRect",
              "controlled": false,
              "attributes": {
                "clipBehavior": "none",
              },
              "child": {
                "type": "Container",
                "id": "cont",
                "controlled": false,
                "attributes": {
                  "width": 100,
                  "height": 100,
                },
              }
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          expect(find.byKey(const ValueKey("clipRect")), findsOneWidget);

          final clipWidget = tester
              .widget<ClipRect>(find.byKey(const ValueKey("clipRect")));

          expect(clipWidget.clipBehavior, Clip.none);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "ClipRect",
              "id": "clipRect",
              "controlled": true,
              "attributes": {
                "clipBehavior": "none",
              },
              "child": {
                "type": "Container",
                "id": "cont",
                "controlled": false,
                "attributes": {
                  "width": 100,
                  "height": 100,
                },
              }
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          expect(find.byKey(const ValueKey("clipRect")), findsOneWidget);

          var clipWidget = tester
              .widget<ClipRect>(find.byKey(const ValueKey("clipRect")));

          expect(clipWidget.clipBehavior, Clip.none);

          await driver.updateAttributes(
            "clipRect",
            {
              "clipBehavior": "hardEdge",
            },
          );

          await tester.pumpAndSettle();

          clipWidget = tester
              .widget<ClipRect>(find.byKey(const ValueKey("clipRect")));

          expect(clipWidget.clipBehavior, Clip.hardEdge);
        },
      );
    },
  );
}
