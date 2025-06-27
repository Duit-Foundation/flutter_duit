import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('DuitDecoratedBox widget tests', () {
    testWidgets(
      'must renders correctly',
      (tester) async {
        final driver = DuitDriver.static(
          {
            'type': 'DecoratedBox',
            'id': 'decorated',
            'attributes': {
              'decoration': {
                'color': '#933C3C',
              },
            },
            'child': {
              'type': 'Container',
              'id': 'child',
              'attributes': {
                'width': 100.0,
                'height': 100.0,
              },
              'controlled': false,
            },
          },
          transportOptions: HttpTransportOptions(),
        );

        await pumpDriver(tester, driver);

        final decoratedBox = find.byKey(const ValueKey('decorated'));
        expect(decoratedBox, findsOneWidget);
        // Проверяем, что цвет применяется (через paints..rect)
        expect(decoratedBox, paints..rect(color: const Color(0xFF933C3C)));
      },
    );

    testWidgets(
      'must update attributes',
      (tester) async {
        final driver = DuitDriver.static(
          {
            'type': 'DecoratedBox',
            'id': 'decorated',
            'controlled': true,
            'attributes': {
              'decoration': {
                'color': '#933C3C',
              },
            },
            'child': {
              'type': 'Container',
              'id': 'child',
              'attributes': {
                'width': 100.0,
                'height': 100.0,
              },
              'controlled': false,
            },
          },
          transportOptions: HttpTransportOptions(),
        );

        await pumpDriver(tester, driver);

        var decoratedBox = find.byKey(const ValueKey('decorated'));
        expect(decoratedBox, findsOneWidget);
        expect(decoratedBox, paints..rect(color: const Color(0xFF933C3C)));

        await driver.updateTestAttributes('decorated', {
          'decoration': {
            'color': '#075eeb',
          },
        });
        await tester.pumpAndSettle();

        decoratedBox = find.byKey(const ValueKey('decorated'));
        expect(decoratedBox, paints..rect(color: const Color(0xFF075eeb)));
      },
    );
  });
}
