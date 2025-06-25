import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    "DuitCheckBox tests",
    () {
      testWidgets(
        "must change value",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CheckBox",
              "id": "box",
              "attributes": {
                "value": true,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          expect(find.byKey(const ValueKey("box")), findsOneWidget);

          await tester.tap(find.byKey(const ValueKey("box")));

          final checkbox =
              tester.widget<Checkbox>(find.byKey(const ValueKey("box")));

          await tester.pumpAndSettle();

          expect(checkbox.value, true);
        },
      );
    },
  );
}
