import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

final _uncIcon = <String, dynamic>{
  "type": "Icon",
  "id": "icon_1",
  "controlled": false,
  "attributes": {
    "icon": "add",
    "size": 24.0,
    "color": "#2196F3",
  },
};

final _uncIconWithoutIcon = <String, dynamic>{
  "type": "Icon",
  "id": "icon_2",
  "controlled": false,
  "attributes": {
    "icon": null,
    "size": 24.0,
  },
};

Map<String, dynamic> _cIcon() {
  return <String, dynamic>{
    "type": "Icon",
    "id": "icon_controlled",
    "controlled": true,
    "attributes": {
      "icon": "star",
      "size": 32.0,
      "color": "#FF9800",
    },
  };
}

void main() {
  group("DuitIcon widget", () {
    testWidgets("check simple render scenario", (tester) async {
      final driver = XDriver.static(_uncIcon);

      await pumpDriver(tester, driver.asInternalDriver);

      final iconFinder = find.byKey(const ValueKey("icon_1"));
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon, Icons.add);
      expect(iconWidget.size, 24.0);
    });

    testWidgets("check icon without icon data renders SizedBox with icon_empty key", (tester) async {
      final driver = XDriver.static(_uncIconWithoutIcon);

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.byKey(const ValueKey("icon_empty")), findsOneWidget);
    });

    testWidgets("check controlled icon update process", (tester) async {
      final driver = XDriver.static(_cIcon());

      await pumpDriver(tester, driver.asInternalDriver);

      var iconWidget =
          tester.widget<Icon>(find.byKey(const ValueKey("icon_controlled")));
      expect(iconWidget.icon, Icons.star);
      expect(iconWidget.size, 32.0);

      await driver.asInternalDriver.updateAttributes("icon_controlled", {
        "icon": "favorite",
        "size": 48.0,
        "color": "#E91E63",
      });

      await tester.pumpAndSettle();

      iconWidget =
          tester.widget<Icon>(find.byKey(const ValueKey("icon_controlled")));
      expect(iconWidget.icon, Icons.favorite);
      expect(iconWidget.size, 48.0);
    });

    testWidgets("check icon with map icon data", (tester) async {
      final driver = XDriver.static(<String, dynamic>{
        "type": "Icon",
        "id": "icon_map",
        "controlled": false,
        "attributes": {
          "icon": {
            "codePoint": 0xe87d,
            "fontFamily": "MaterialIcons",
          },
          "size": 20.0,
        },
      });

      await pumpDriver(tester, driver.asInternalDriver);

      final iconFinder = find.byKey(const ValueKey("icon_map"));
      expect(iconFinder, findsOneWidget);
    });
  });
}
