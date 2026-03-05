import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, Object> generateSliverIgnorePointerJson({
  ignoring = true,
  needsBoxAdapter = false,
  controlled = false,
}) =>
    {
      "type": "CustomScrollView",
      "id": "custom_view",
      "controlled": false,
      "attributes": <String, dynamic>{},
      "children": [
        {
          "type": "SliverIgnorePointer",
          "id": "sliver_ignore",
          "controlled": controlled,
          "attributes": {
            "ignoring": ignoring,
            "needsBoxAdapter": needsBoxAdapter,
          },
          "child": {
            "type": "Text",
            "id": "text",
            "controlled": false,
            "attributes": {
              "data": "Some text",
            },
          },
        },
      ],
    };

void main() {
  group("DuitSliverIgnorePointer tests", () {
    testWidgets("must renders correctly", (tester) async {
      final driver = XDriver.static(
        generateSliverIgnorePointerJson(ignoring: true, needsBoxAdapter: true),
      );
      await pumpDriver(tester, driver.asInternalDriver);
      expect(find.byKey(const ValueKey("sliver_ignore")), findsOneWidget);
      expect(find.byKey(const ValueKey("text")), findsOneWidget);
      // Проверяем, что IgnorePointer реально блокирует pointer events
      final sliver = tester.widget<SliverIgnorePointer>(
        find.byKey(const ValueKey("sliver_ignore")),
      );
      expect(sliver.ignoring, true);
    });

    testWidgets("must update attributes", (tester) async {
      final driver = XDriver.static(
        generateSliverIgnorePointerJson(
          ignoring: true,
          needsBoxAdapter: true,
          controlled: true,
        ),
      );
      await pumpDriver(tester, driver.asInternalDriver);

      expect(
        tester
            .widget<SliverIgnorePointer>(
              find.byKey(const ValueKey("sliver_ignore")),
            )
            .ignoring,
        true,
      );

      await driver.asInternalDriver.updateAttributes("sliver_ignore", {
        "ignoring": false,
        "needsBoxAdapter": true,
      });

      await tester.pumpAndSettle();
      expect(
        tester
            .widget<SliverIgnorePointer>(
              find.byKey(const ValueKey("sliver_ignore")),
            )
            .ignoring,
        false,
      );
    });
  });
}
