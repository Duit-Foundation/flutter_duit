import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool val = false]) {
  return {
    "type": "AbsorbPointer",
    "id": "absorb",
    "controlled": val,
    "attributes": {
      "absorbing": true,
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
  group(
    "DuitAbsorbPointer widget tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = DuitDriver.static(
            _createWidget(),
            transportOptions: HttpTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          final widget = find.byKey(const ValueKey("absorb"));

          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            _createWidget(true),
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          var widget = find.byKey(const ValueKey("absorb"));

          expect(widget, findsOneWidget);

          var absorbWidget = tester.widget<AbsorbPointer>(widget);

          expect(absorbWidget.absorbing, true);

          await driver.updateAttributes(
            "absorb",
            {
              "absorbing": false,
            },
          );

          await tester.pumpAndSettle();

          widget = find.byKey(const ValueKey("absorb"));
          absorbWidget = tester.widget<AbsorbPointer>(widget);
          expect(absorbWidget.absorbing, false);
        },
      );
    },
  );
}
