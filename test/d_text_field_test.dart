import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('DuitTextField widget tests', () {
    testWidgets('renders with all attributes', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'TextField',
          'id': 'textField1',
          'controlled': true,
          'attributes': {
            'value': 'Hello',
            'autofocus': false,
            'enabled': true,
            'readOnly': false,
            'maxLength': 20,
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final textFieldFinder = find.byKey(const ValueKey('textField1'));
      expect(textFieldFinder, findsOneWidget);
      final textFieldWidget = tester.widget<TextField>(textFieldFinder);
      expect(textFieldWidget.controller?.text, 'Hello');
      expect(textFieldWidget.maxLength, 20);
      expect(textFieldWidget.enabled, true);
      expect(textFieldWidget.readOnly, false);
    });

    testWidgets('user can enter text', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'TextField',
          'id': 'textField2',
          'controlled': true,
          'attributes': {
            'value': '',
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final textFieldFinder = find.byKey(const ValueKey('textField2'));
      expect(textFieldFinder, findsOneWidget);

      await tester.enterText(textFieldFinder, 'Flutter');
      await tester.pumpAndSettle();

      final textFieldWidget = tester.widget<TextField>(textFieldFinder);
      expect(textFieldWidget.controller?.text, 'Flutter');
    });

    testWidgets('controlled: updates value', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'TextField',
          'id': 'textField3',
          'controlled': true,
          'attributes': {
            'value': 'Initial',
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final textFieldFinder = find.byKey(const ValueKey('textField3'));
      expect(textFieldFinder, findsOneWidget);
      expect(tester.widget<TextField>(textFieldFinder).controller?.text,
          'Initial');

      await driver.updateTestAttributes('textField3', {'value': 'Updated'});
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(textFieldFinder).controller?.text,
          'Updated');
    });
  });
}
