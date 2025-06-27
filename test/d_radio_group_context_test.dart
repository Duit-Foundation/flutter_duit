import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitRadio + RadioGroupContext integration",
    () {
      testWidgets(
        "must update groupValue and sync all radios",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "RadioGroupContext",
              "id": "group1",
              "controlled": true,
              "attributes": {"groupValue": "a"},
              "child": {
                "type": "Row",
                "id": "row1",
                "controlled": false,
                "children": [
                  {
                    "type": "Radio",
                    "id": "radioA",
                    "controlled": false,
                    "attributes": {"value": "a"},
                  },
                  {
                    "type": "Radio",
                    "id": "radioB",
                    "controlled": false,
                    "attributes": {"value": "b"},
                  },
                ]
              }
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final radioAFinder = find.byKey(const ValueKey("radioA"));
          final radioBFinder = find.byKey(const ValueKey("radioB"));

          expect(radioAFinder, findsOneWidget);
          expect(radioBFinder, findsOneWidget);

          Radio radioA = tester.widget<Radio>(radioAFinder);
          Radio radioB = tester.widget<Radio>(radioBFinder);

          expect(radioA.groupValue, "a");
          expect(radioA.value, "a");
          expect(radioA.value == radioA.groupValue, isTrue);
          expect(radioB.value == radioA.groupValue, isFalse);

          // Эмулируем выбор второго радио
          await tester.tap(radioBFinder);
          await tester.pumpAndSettle();

          radioA = tester.widget<Radio>(radioAFinder);
          radioB = tester.widget<Radio>(radioBFinder);

          expect(radioA.groupValue, "b");
          expect(radioB.groupValue, "b");
          expect(radioA.value == radioA.groupValue, isFalse);
          expect(radioB.value == radioB.groupValue, isTrue);
        },
      );

      testWidgets(
        "must update Radio attributes (activeColor)",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "RadioGroupContext",
              "id": "group1",
              "controlled": true,
              "attributes": {"groupValue": "a"},
              "child": {
                "type": "Radio",
                "id": "radioA",
                "controlled": true,
                "attributes": {"value": "a", "activeColor": "#075eeb"},
              }
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final radioFinder = find.byKey(const ValueKey("radioA"));
          expect(radioFinder, findsOneWidget);

          Radio radio = tester.widget<Radio>(radioFinder);
          expect(radio.activeColor, const Color(0xFF075EEB));

          await driver.updateTestAttributes(
            "radioA",
            {"activeColor": "#03fcc2", "value": "a"},
          );
          await tester.pumpAndSettle();

          radio = tester.widget<Radio>(radioFinder);
          expect(radio.activeColor, const Color(0xFF03FCC2));
        },
      );
    },
  );
}
