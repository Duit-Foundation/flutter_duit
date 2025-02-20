import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _createWidget(
    {bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true}) {
  return {
    "type": "SafeArea",
    "id": "safeAreaId",
    "controlled": false,
    "attributes": {
      "top": top,
      "bottom": bottom,
      "left": left,
      "right": right,
      "minimum": [0, 0],
      "maintainBottomViewPadding": false,
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
  });
}
