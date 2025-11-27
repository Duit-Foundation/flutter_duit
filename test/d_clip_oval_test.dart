import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitClipOval tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "ClipOval",
              "id": "ClipOval",
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

          expect(find.byKey(const ValueKey("ClipOval")), findsOneWidget);

          final clipWidget =
              tester.widget<ClipOval>(find.byKey(const ValueKey("ClipOval")));

          expect(clipWidget.clipBehavior, Clip.none);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "ClipOval",
              "id": "ClipOval",
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

          expect(find.byKey(const ValueKey("ClipOval")), findsOneWidget);

          var clipWidget =
              tester.widget<ClipOval>(find.byKey(const ValueKey("ClipOval")));

          expect(clipWidget.clipBehavior, Clip.none);

          await driver.updateAttributes(
            "ClipOval",
            {
              "clipBehavior": "hardEdge",
            },
          );

          await tester.pumpAndSettle();

          clipWidget =
              tester.widget<ClipOval>(find.byKey(const ValueKey("ClipOval")));

          expect(clipWidget.clipBehavior, Clip.hardEdge);
        },
      );
    },
  );
}
