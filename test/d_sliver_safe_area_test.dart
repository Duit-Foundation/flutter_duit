import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_duit/flutter_duit.dart";

import "utils.dart";

void main() {
  group("DuitSliverSafeArea widget tests", () {
    testWidgets("DuitSliverSafeArea must renders correctly", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "CustomScrollView",
          "id": "custom_view",
          "controlled": false,
          "attributes": <String, dynamic>{},
          "children": [
            {
              "type": "SliverSafeArea",
              "id": "sliverSafeAreaId",
              "controlled": false,
              "attributes": {
                "left": true,
                "top": true,
                "right": true,
                "bottom": true,
                "minimum": {
                  "top": 10.0,
                  "left": 10.0,
                  "right": 10.0,
                  "bottom": 10.0,
                },
                "needsBoxAdapter": true,
              },
              "child": {
                "type": "Text",
                "id": "textId",
                "controlled": false,
                "attributes": {
                  "data": "Test Text",
                },
              },
            },
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      expect(find.byKey(const ValueKey("sliverSafeAreaId")), findsOneWidget);
      expect(find.text("Test Text"), findsOneWidget);
    });

    testWidgets("DuitControlledSliverSafeArea must renders correctly",
        (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "CustomScrollView",
          "id": "custom_view",
          "controlled": false,
          "attributes": <String, dynamic>{},
          "children": [
            {
              "type": "SliverSafeArea",
              "id": "sliverSafeAreaId",
              "controlled": true,
              "attributes": {
                "left": false,
                "top": false,
                "right": true,
                "bottom": true,
                "needsBoxAdapter": true,
              },
              "child": {
                "type": "Text",
                "id": "textId",
                "controlled": false,
                "attributes": {
                  "data": "Controlled Test Text",
                },
              },
            },
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      expect(find.byKey(const ValueKey("sliverSafeAreaId")), findsOneWidget);
      expect(find.text("Controlled Test Text"), findsOneWidget);

      await driver.updateAttributes(
        "sliverSafeAreaId",
        {
          "left": true,
        },
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey("sliverSafeAreaId")), findsOneWidget);
      expect(find.text("Controlled Test Text"), findsOneWidget);

      final widget = tester.widget<SliverSafeArea>(
        find.byKey(const ValueKey("sliverSafeAreaId")),
      );

      expect(widget.left, isTrue);
    });

    testWidgets(
        "SliverSafeArea with needsBoxAdapter should wrap child in SliverToBoxAdapter",
        (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "CustomScrollView",
          "id": "custom_view",
          "controlled": false,
          "attributes": <String, dynamic>{},
          "children": [
            {
              "type": "SliverSafeArea",
              "id": "sliverSafeAreaId",
              "controlled": false,
              "attributes": {
                "left": true,
                "top": true,
                "right": true,
                "bottom": true,
                "needsBoxAdapter": true,
              },
              "child": {
                "type": "Text",
                "id": "textId",
                "controlled": false,
                "attributes": {
                  "data": "Box Adapter Test",
                },
              },
            },
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver);

      expect(find.byKey(const ValueKey("sliverSafeAreaId")), findsOneWidget);
      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
      expect(find.text("Box Adapter Test"), findsOneWidget);
    });
  });
}
