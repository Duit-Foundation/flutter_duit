import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group(
    "DuitContainer widget tests",
    () {
      testWidgets("must build widget", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Container",
            "id": "container",
            "attributes": {
              "width": 100,
              "height": 100,
              "decoration": <String, dynamic>{
                "color": [
                  0,
                  0,
                  0,
                  1,
                ],
              },
            },
            "controlled": false,
          },
          transportOptions: EmptyTransportOptions(),
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

        final box = find.byKey(const ValueKey("container"));

        expect(box, paints..rect(color: Colors.black));
      });

      testWidgets("must update widget", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Container",
            "id": "container",
            "attributes": {
              "width": 100,
              "height": 100,
              "decoration": <String, dynamic>{
                "color": [
                  0,
                  0,
                  0,
                  1,
                ],
              },
            },
            "controlled": true,
          },
          transportOptions: EmptyTransportOptions(),
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

        var box = find.byKey(const ValueKey("container"));

        expect(box, paints..rect(color: Colors.black));

        await driver.updateTestAttributes("container", {
          "decoration": <String, dynamic>{
            "color": "#FFFFFF",
          },
        });

        await tester.pumpAndSettle();

        box = find.byKey(const ValueKey("container"));

        expect(
          box,
          paints
            ..rect(
              color: Colors.white,
            ),
        );
      });
    },
  );
}
