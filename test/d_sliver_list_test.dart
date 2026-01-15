import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createSliverListWidget() {
  return {
    "type": "CustomScrollView",
    "id": "custom_view",
    "controlled": false,
    "attributes": <String, dynamic>{},
    "children": [
      {
        "controlled": true,
        "id": "sliver_list",
        "type": "SliverList",
        "attributes": {
          "type": 1,
          "childObjects": [
            {
              "controlled": true,
              "action": null,
              "id": "1",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "2",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "3",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "4",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "5",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            }
          ],
          "addAutomaticKeepAlives": true,
          "addRepaintBoundaries": true,
          "addSemanticIndexes": true,
        },
      }
    ],
  };
}

Map<String, dynamic> _createSliverListCommonWidget([bool isControlled = true]) {
  return {
    "type": "CustomScrollView",
    "id": "custom_view",
    "controlled": false,
    "attributes": <String, dynamic>{},
    "children": [
      {
        "controlled": isControlled,
        "id": "sliver_list_common",
        "type": "SliverList",
        "attributes": {
          "type": 0,
          "addAutomaticKeepAlives": true,
          "addRepaintBoundaries": true,
          "addSemanticIndexes": true,
        },
        "children": [
          {
            "type": "Container",
            "id": "item1",
            "controlled": false,
            "attributes": {
              "color": "#FF0000",
              "width": 100,
              "height": 50,
            },
          },
          {
            "type": "Container",
            "id": "item2",
            "controlled": false,
            "attributes": {
              "color": "#00FF00",
              "width": 100,
              "height": 50,
            },
          },
          {
            "type": "Container",
            "id": "item3",
            "controlled": false,
            "attributes": {
              "color": "#0000FF",
              "width": 100,
              "height": 50,
            },
          },
        ],
      }
    ],
  };
}

Map<String, dynamic> _createSliverListControlledWidget() {
  return {
    "type": "CustomScrollView",
    "id": "custom_view",
    "controlled": false,
    "attributes": <String, dynamic>{},
    "children": [
      {
        "controlled": true,
        "id": "sliver_list_controlled",
        "type": "SliverList",
        "attributes": {
          "type": 0,
          "addAutomaticKeepAlives": true,
          "addRepaintBoundaries": true,
          "addSemanticIndexes": true,
        },
        "children": [
          {
            "type": "Container",
            "id": "controlled_item1",
            "controlled": false,
            "attributes": {
              "color": "#FF0000",
              "width": 100,
              "height": 50,
            },
          },
          {
            "type": "Container",
            "id": "controlled_item2",
            "controlled": false,
            "attributes": {
              "color": "#00FF00",
              "width": 100,
              "height": 50,
            },
          },
        ],
      }
    ],
  };
}

Map<String, dynamic> _createSliverListSeparatedWidget() {
  return {
    "type": "CustomScrollView",
    "id": "custom_view",
    "controlled": false,
    "attributes": <String, dynamic>{},
    "children": [
      {
        "controlled": true,
        "id": "separeted_list",
        "type": "SliverList",
        "attributes": {
          "type": 2,
          "childObjects": [
            {
              "controlled": true,
              "action": null,
              "id": "1",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "2",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            },
            {
              "controlled": true,
              "action": null,
              "id": "3",
              "type": "Component",
              "data": {
                "come": "value",
              },
              "tag": "c",
            }
          ],
          "separator": {
            "type": "Container",
            "id": "separator",
            "controlled": false,
            "attributes": {
              "color": "#FF0000",
              "height": 10,
              "width": 100,
            },
          },
          "addAutomaticKeepAlives": true,
          "addRepaintBoundaries": true,
          "addSemanticIndexes": true,
        },
      }
    ],
  };
}

void main() {
  setUpAll(
    () async {
      await DuitRegistry.initialize();

      await DuitRegistry.registerComponents([
        {
          "tag": "c",
          "layoutRoot": {
            "type": "Container",
            "tag": "c",
            "id": "ckk",
            "controlled": false,
            "attributes": {
              "color": "#DCDCDC",
              "width": 100,
              "height": 100,
            },
          },
        }
      ]);
    },
  );

  group(
    "SliverList tests",
    () {
      testWidgets(
        "DuitControlledSliverList must render correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListCommonWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(
            find.byKey(const ValueKey("sliver_list_common")),
            findsOneWidget,
          );
          expect(find.byKey(const ValueKey("item1")), findsOneWidget);
          expect(find.byKey(const ValueKey("item2")), findsOneWidget);
          expect(find.byKey(const ValueKey("item3")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitSliverList must render correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListCommonWidget(false),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(
            find.byKey(const ValueKey("sliver_list_common")),
            findsOneWidget,
          );
          expect(find.byKey(const ValueKey("item1")), findsOneWidget);
          expect(find.byKey(const ValueKey("item2")), findsOneWidget);
          expect(find.byKey(const ValueKey("item3")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitControlledSliverList must render correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListControlledWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(
            find.byKey(const ValueKey("sliver_list_controlled")),
            findsOneWidget,
          );
          expect(
            find.byKey(const ValueKey("controlled_item1")),
            findsOneWidget,
          );
          expect(
            find.byKey(const ValueKey("controlled_item2")),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        "DuitSliverListBuilder must render correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("sliver_list")), findsOneWidget);
          expect(find.byKey(const ValueKey("1")), findsOneWidget);
          expect(find.byKey(const ValueKey("5")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitSliverListSeparated must render correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListSeparatedWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          expect(find.byKey(const ValueKey("1")), findsOneWidget);
          expect(find.byKey(const ValueKey("3")), findsOneWidget);
        },
      );

      testWidgets(
        "DuitSliverList must handle scrolling correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListCommonWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          final scroll = find.byType(Scrollable);
          final itemFirst = find.byKey(const ValueKey("item1"));
          final itemLast = find.byKey(const ValueKey("item3"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(itemLast, findsOneWidget);

          await tester.scrollUntilVisible(
            itemFirst,
            -1000,
            scrollable: scroll,
          );

          expect(itemFirst, findsOneWidget);
        },
      );

      testWidgets(
        "DuitSliverListBuilder must handle scrolling correctly",
        (tester) async {
          final driver = XDriver.static(
            _createSliverListWidget(),
          );

          await pumpDriver(
            tester, driver.asInternalDriver,
          );

          final scroll = find.byType(Scrollable);
          final itemFirst = find.byKey(const ValueKey("1"));
          final itemLast = find.byKey(const ValueKey("5"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(itemLast, findsOneWidget);

          await tester.scrollUntilVisible(
            itemFirst,
            -1000,
            scrollable: scroll,
          );

          expect(itemFirst, findsOneWidget);
        },
      );
    },
  );
}
