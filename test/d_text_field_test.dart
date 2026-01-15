import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group("DuitTextField widget tests", () {
    testWidgets("renders with all attributes", (tester) async {
      final driver = XDriver.static(
        {
          "type": "TextField",
          "id": "textField1",
          "controlled": true,
          "attributes": {
            "value": "Hello",
            "autofocus": false,
            "enabled": true,
            "readOnly": false,
            "maxLength": 20,
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      final textFieldFinder = find.byKey(const ValueKey("textField1"));
      expect(textFieldFinder, findsOneWidget);
      final textFieldWidget = tester.widget<TextField>(textFieldFinder);
      expect(textFieldWidget.controller?.text, "Hello");
      expect(textFieldWidget.maxLength, 20);
      expect(textFieldWidget.enabled, true);
      expect(textFieldWidget.readOnly, false);
    });

    testWidgets("controlled: updates value", (tester) async {
      final driver = XDriver.static(
        {
          "type": "TextField",
          "id": "textField3",
          "controlled": true,
          "attributes": {
            "value": "Initial",
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      final textFieldFinder = find.byKey(const ValueKey("textField3"));
      expect(textFieldFinder, findsOneWidget);
      expect(
        tester.widget<TextField>(textFieldFinder).controller?.text,
        "Initial",
      );

      await driver.asInternalDriver.updateAttributes("textField3", {"value": "Updated"});
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(textFieldFinder).controller?.text,
        "Updated",
      );
    });
  });
}
