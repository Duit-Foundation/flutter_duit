import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    'type': 'Offstage',
    'id': 'offstage_test',
    'controlled': isControlled,
    'attributes': {'offstage': true},
    'child': {
      'type': 'Container',
      'id': 'con',
      'controlled': false,
      'attributes': {'color': '#DCDCDC', 'width': 50, 'height': 50}
    }
  };
}

void main() {
  group('DuitOffstage widget tests', () {
    testWidgets('check widget', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey('offstage_test'));

      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(true),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        final widget = find.byKey(const ValueKey('offstage_test'));
        expect(widget, findsOneWidget);

        await driver.updateTestAttributes(
          "offstage_test",
          {
            "offstage": false,
          },
        );

        await tester.pumpAndSettle();

        final offstage = tester.widget<Offstage>(widget);
        expect(offstage.offstage, false);
      },
    );
  });
}
