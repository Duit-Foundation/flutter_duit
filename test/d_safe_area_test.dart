import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

Map<String, dynamic> _createWidget({
  bool top = true,
  bool bottom = true,
  bool left = true,
  bool right = true,
  controlled = false,
}) {
  return {
    "type": "SafeArea",
    "id": "safeAreaId",
    "controlled": controlled,
    "attributes": {
      "top": top,
      "bottom": bottom,
      "left": left,
      "right": right,
      "minimum": [0, 0],
    },
    "child": {
      "type": "Container",
      "id": "conId",
      "controlled": false,
      "attributes": {
        "color": "#075eeb",
      },
    }
  };
}

void main() {
  group("DuitSafeArea widget tests", () {
    testWidgets("check widget", (tester) async {
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

      final widget = find.byKey(const ValueKey("safeAreaId"));

      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(
            top: false,
            left: false,
            right: true,
            bottom: true,
            controlled: true,
          ),
          transportOptions: HttpTransportOptions(),
          enableDevMetrics: false,
        );

        await pumpDriver(tester, driver);

        // Проверяем начальные значения
        var safeArea = find.byKey(const ValueKey("safeAreaId"));
        expect(safeArea, findsOneWidget);
        var safeAreaWidget = tester.widget<SafeArea>(safeArea);
        expect(safeAreaWidget.top, isFalse);
        expect(safeAreaWidget.left, isFalse);
        expect(safeAreaWidget.right, isTrue);
        expect(safeAreaWidget.bottom, isTrue);

        // Обновляем атрибуты
        await driver.updateTestAttributes("safeAreaId", {
          "top": true,
          "left": true,
          "right": false,
          "bottom": false,
          "minimum": [10.0, 20.0, 30.0, 40.0],
          "maintainBottomViewPadding": true,
        });
        await tester.pumpAndSettle();

        safeArea = find.byKey(const ValueKey("safeAreaId"));
        safeAreaWidget = tester.widget<SafeArea>(safeArea);
        expect(safeAreaWidget.top, isTrue);
        expect(safeAreaWidget.left, isTrue);
        expect(safeAreaWidget.right, isFalse);
        expect(safeAreaWidget.bottom, isFalse);
        expect(
            safeAreaWidget.minimum,
            const EdgeInsets.only(
              left: 10.0,
              top: 20.0,
              right: 30.0,
              bottom: 40.0,
            ));
      },
    );

    testWidgets(" minimum and maintainBottomViewPadding attributes",
        (tester) async {
      final widgetMap = _createWidget();
      widgetMap["attributes"] = {
        ...widgetMap["attributes"],
        "minimum": [5.0, 6.0, 7.0, 8.0],
        "maintainBottomViewPadding": true,
      };
      final driver = DuitDriver.static(
        widgetMap,
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(driver: driver),
        ),
      );
      await tester.pumpAndSettle();
      final safeArea = find.byKey(const ValueKey("safeAreaId"));
      expect(safeArea, findsOneWidget);
      final safeAreaWidget = tester.widget<SafeArea>(safeArea);
      expect(safeAreaWidget.minimum,
          const EdgeInsets.only(left: 5.0, top: 6.0, right: 7.0, bottom: 8.0));
      expect(safeAreaWidget.maintainBottomViewPadding, isTrue);
    });
  });
}
