import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';

import 'utils.dart';

void main() {
  group('DuitOverflowBox widget tests', () {
    testWidgets('renders with all attributes', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'OverflowBox',
          'id': 'overflow',
          'controlled': false,
          'attributes': {
            'minWidth': 50.0,
            'maxWidth': 200.0,
            'minHeight': 30.0,
            'maxHeight': 150.0,
            'fit': 'deferToChild',
            'alignment': 'topLeft',
          },
          'child': {
            'type': 'Container',
            'id': 'child',
            'controlled': false,
            'attributes': {
              'width': 100.0,
              'height': 100.0,
              'decoration': {
                'color': '#DCDCDC',
              },
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final overflowFinder = find.byKey(const ValueKey('overflow'));
      expect(overflowFinder, findsOneWidget);

      final overflowWidget = tester.widget<OverflowBox>(overflowFinder);
      expect(overflowWidget.minWidth, 50.0);
      expect(overflowWidget.maxWidth, 200.0);
      expect(overflowWidget.minHeight, 30.0);
      expect(overflowWidget.maxHeight, 150.0);
      expect(overflowWidget.fit, OverflowBoxFit.deferToChild);
      expect(overflowWidget.alignment, Alignment.topLeft);
    });

    testWidgets('controlled: updates attributes', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'OverflowBox',
          'id': 'overflow',
          'controlled': true,
          'attributes': {
            'minWidth': 10.0,
            'maxWidth': 100.0,
            'minHeight': 10.0,
            'maxHeight': 100.0,
            'fit': 'max',
            'alignment': 'center',
          },
          'child': {
            'type': 'Container',
            'id': 'child',
            'controlled': false,
            'attributes': {
              'width': 20.0,
              'height': 20.0,
              'decoration': {
                'color': '#933C3C',
              },
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final overflowFinder = find.byKey(const ValueKey('overflow'));
      expect(overflowFinder, findsOneWidget);

      var overflowWidget = tester.widget<OverflowBox>(overflowFinder);
      expect(overflowWidget.minWidth, 10.0);
      expect(overflowWidget.maxWidth, 100.0);
      expect(overflowWidget.minHeight, 10.0);
      expect(overflowWidget.maxHeight, 100.0);
      expect(overflowWidget.fit, OverflowBoxFit.max);
      expect(overflowWidget.alignment, Alignment.center);

      await driver.updateTestAttributes('overflow', {
        'minWidth': 5.0,
        'maxWidth': 50.0,
        'minHeight': 5.0,
        'maxHeight': 50.0,
        'fit': 'deferToChild',
        'alignment': 'bottomRight',
      });
      await tester.pumpAndSettle();

      overflowWidget = tester.widget<OverflowBox>(overflowFinder);
      expect(overflowWidget.minWidth, 5.0);
      expect(overflowWidget.maxWidth, 50.0);
      expect(overflowWidget.minHeight, 5.0);
      expect(overflowWidget.maxHeight, 50.0);
      expect(overflowWidget.fit, OverflowBoxFit.deferToChild);
      expect(overflowWidget.alignment, Alignment.bottomRight);
    });
  });
}
