import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group("Fragment rendering", () {
    testWidgets("must render simple fragment", (tester) async {
      final driver = XDriver.static(
        {
          "type": "Fragment",
          "tag": "test",
          "id": "some_id",
        },
      );

      DuitRegistry.registerFragment(
        "test",
        {
          "type": "Text",
          "id": "text",
          "controlled": false,
          "attributes": {
            "data": "Hello, world!",
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Hello, world!"), findsOneWidget);
      // Fragment must overwrite id with inner element id
      expect(find.byKey(const ValueKey("text")), findsOneWidget);
    });

    testWidgets("must render empty when invalid tag provided", (tester) async {
      final driver = XDriver.static(
        {
          "type": "Fragment",
          "tag": "unknown",
          "id": "frag_invalid",
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      if (throwOnUnspecifiedWidgetType) {
        expect(tester.takeException(), isInstanceOf<ArgumentError>());
      } else {
        expect(find.byType(SizedBox), findsOneWidget);
      }
    });

    testWidgets("must support nested fragments", (tester) async {
      final driver = XDriver.static(
        {
          "type": "Fragment",
          "tag": "outer",
          "id": "root",
        },
      );

      // inner -> Text("OK")
      DuitRegistry.registerFragment(
        "inner",
        {
          "type": "Text",
          "id": "text_ok",
          "controlled": false,
          "attributes": {"data": "OK"},
        },
      );

      // outer -> Fragment(inner)
      DuitRegistry.registerFragment(
        "outer",
        {
          "type": "Fragment",
          "tag": "inner",
          "id": "inner_use",
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("OK"), findsOneWidget);
    });

    testWidgets("must allow multiple instances of the same fragment",
        (tester) async {
      DuitRegistry.registerFragment(
        "dup",
        {
          "type": "Text",
          "id": "dup_text",
          "controlled": false,
          "attributes": {
            "data": "Hello",
          },
        },
      );

      final driver = XDriver.static(
        {
          "type": "Row",
          "id": "row_root",
          "controlled": false,
          "children": [
            <String, dynamic>{
              "type": "Fragment",
              "tag": "dup",
              "id": "f1",
            },
            <String, dynamic>{
              "type": "Fragment",
              "tag": "dup",
              "id": "f2",
            },
          ],
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Hello"), findsNWidgets(2));
    });
  });
}
