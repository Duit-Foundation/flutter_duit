import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "IntrinsicHeight",
    "id": "intrinsicHeightId",
    "controlled": isControlled,
    "child": {
      "type": "Container",
      "id": "conId",
      "controlled": false,
      "attributes": {
        "color": "#075eeb",
      },
    },
  };
}

void main() {
  group("DuitIntrinsicHeight widget tests", () {
    testWidgets("check widget", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(),
        transportOptions: HttpTransportOptions(),
      );

      await pumpDriver(tester, driver);

      expect(find.byKey(const ValueKey("intrinsicHeightId")), findsOneWidget);
    });

    testWidgets("controlled variant", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(true),
        transportOptions: HttpTransportOptions(),
      );

      await pumpDriver(tester, driver);

      expect(find.byKey(const ValueKey("intrinsicHeightId")), findsOneWidget);
    });
  });
}
