import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _createWidget() {
  return {
    "type": "IntrinsicWidth",
    "id": "intrinsicWidthId",
    "controlled": false,
    // "attributes": {
    //   "top": top,
    //   "bottom": bottom,
    //   "left": left,
    //   "right": right,
    //   "minimum": [0, 0],
    //   "maintainBottomViewPadding": false,
    // },
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
  group("DuitIntrinsicWidth widget tests", () {
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

      final widget = find.byKey(const ValueKey("intrinsicWidthId"));

      expect(widget, findsOneWidget);
    });
  });
}
