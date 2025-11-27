import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitFittedBox tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Container",
              "id": "sized",
              "controlled": false,
              "attributes": {
                "width": 300.0,
                "height": 20.0,
                "color": Colors.red,
              },
              "child": {
                "type": "FittedBox",
                "id": "fited",
                "controlled": false,
                "attributes": {
                  "fit": "fitWidth",
                },
                "child": {
                  "type": "Text",
                  "id": "text",
                  "controlled": false,
                  "attributes": {
                    "data": "Test widget",
                    "style": {
                      "fontSize": 50.0,
                    }
                  },
                },
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("text")), findsOneWidget);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Container",
              "id": "sized",
              "controlled": false,
              "attributes": {
                "width": 300.0,
                "height": 20.0,
                "color": Colors.red,
              },
              "child": {
                "type": "FittedBox",
                "id": "fited",
                "controlled": true,
                "attributes": {
                  "fit": "fitWidth",
                },
                "child": {
                  "type": "Text",
                  "id": "text",
                  "controlled": false,
                  "attributes": {
                    "data": "Test widget",
                    "style": {
                      "fontSize": 50.0,
                    }
                  },
                },
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          var box = find.byKey(const ValueKey("fited"));
          var boxW = tester.widget<FittedBox>(box);
          expect(box, findsOneWidget);
          expect(boxW.fit, BoxFit.fitWidth);

          await driver.updateAttributes("fited", {"fit": "contain"});

          await tester.pumpAndSettle();

          box = find.byKey(const ValueKey("fited"));
          boxW = tester.widget<FittedBox>(box);
          expect(boxW.fit, BoxFit.contain);
        },
      );
    },
  );
}
