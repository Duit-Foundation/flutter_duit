import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('DuitSlider widget tests', () {
    testWidgets('renders with all attributes', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'Slider',
          'id': 'slider1',
          'controlled': true,
          'attributes': {
            'value': 0.5,
            'min': 0.0,
            'max': 1.0,
            'divisions': 10,
            'label': 'Test',
            'activeColor': '#933C3C',
            'inactiveColor': '#DCDCDC',
            'thumbColor': '#075eeb',
            'autofocus': true,
            'allowedInteraction': 'tapAndSlide',
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final sliderFinder = find.byKey(const ValueKey('slider1'));
      expect(sliderFinder, findsOneWidget);

      final sliderWidget = tester.widget<Slider>(sliderFinder);
      expect(sliderWidget.value, 0.5);
      expect(sliderWidget.min, 0.0);
      expect(sliderWidget.max, 1.0);
      expect(sliderWidget.divisions, 10);
      expect(sliderWidget.label, 'Test');
      expect(sliderWidget.activeColor, const Color(0xFF933C3C));
      expect(sliderWidget.inactiveColor, const Color(0xFFDCDCDC));
      expect(sliderWidget.thumbColor, const Color(0xFF075EEB));
      expect(sliderWidget.autofocus, true);
      expect(sliderWidget.allowedInteraction, SliderInteraction.tapAndSlide);
    });

    testWidgets('user interaction changes value', (tester) async {
      final driver = DuitDriver.static(
        {
          'type': 'Slider',
          'id': 'slider3',
          'controlled': true,
          'attributes': {
            'value': 0.1,
            'min': 0.0,
            'max': 1.0,
          },
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      final sliderFinder = find.byKey(const ValueKey('slider3'));
      expect(sliderFinder, findsOneWidget);
      expect(tester.widget<Slider>(sliderFinder).value, 0.1);

      // Эмулируем drag на 80% ширины
      final sliderCenter = tester.getCenter(sliderFinder);
      final sliderWidth = tester.getSize(sliderFinder).width;
      final target =
          Offset(sliderCenter.dx + sliderWidth * 0.3, sliderCenter.dy);
      await tester.drag(sliderFinder, target - sliderCenter);
      await tester.pumpAndSettle();

      // Проверяем, что значение изменилось (точное значение зависит от реализации)
      expect(tester.widget<Slider>(sliderFinder).value, isNot(0.1));
    });
  });
}
