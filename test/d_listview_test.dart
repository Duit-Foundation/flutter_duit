import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget(int type) {
  return {
    "controlled": true,
    "id": "87b54621-ac6d-42c3-8d1f-397e3bd63bca",
    "type": "ListView",
    "attributes": {
      "type": type,
      "separator": <String, dynamic>{
        "type": "Component",
        "id": "sep1",
        "controlled": true,
        "data": {},
        "tag": "sep"
      },
      "childObjects": [
        {
          "controlled": true,
          "action": null,
          "id": "1",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "2",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "3",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "4",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "5",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "6",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "7",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "8",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "9",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        },
        {
          "controlled": true,
          "action": null,
          "id": "10",
          "type": "Component",
          "data": {
            "come": "value",
          },
          "tag": "c"
        }
      ],
      "shrinkWrap": true
    }
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
              "height": 1000,
            },
          },
        },
        {
          "tag": "sep",
          "layoutRoot": {
            "type": "Container",
            "tag": "c",
            "id": "ckk",
            "controlled": false,
            "attributes": {
              "color": "#FCFCFC",
              "width": 100,
              "height": 12,
            },
          },
        }
      ]);
    },
  );

  testWidgets("ListView must renders correctly", (tester) async {
    final driver = DuitDriver.static(
      {
        "controlled": false,
        "id": "list1",
        "type": "ListView",
        "attributes": {
          "type": 0,
          "itemExtent": 100.0,
        },
        "children": List.generate(
            100,
            (i) => <String, dynamic>{
                  "type": "Container",
                  "id": i.toString(),
                  "controlled": false,
                  "attributes": {
                    "height": 100.0,
                    "width": 100.0,
                    "color": "#DCDCDC",
                  },
                }),
      },
      transportOptions: EmptyTransportOptions(),
    );

    await pumpDriver(
      tester,
      driver,
    );

    expect(find.byKey(const ValueKey("list1")), findsOneWidget);

    final scroll = find.byType(Scrollable);
    final itemFirst = find.byKey(const ValueKey("1"));
    final itemLast = find.byKey(const ValueKey("99"));

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
  });

  testWidgets("ListView must update attributes", (tester) async {
    final driver = DuitDriver.static(
      {
        "controlled": true,
        "id": "list1",
        "type": "ListView",
        "attributes": {
          "type": 0,
          "itemExtent": 100.0,
        },
        "children": List.generate(
            100,
            (i) => <String, dynamic>{
                  "type": "Container",
                  "id": i.toString(),
                  "controlled": false,
                  "attributes": {
                    "height": 100.0,
                    "width": 100.0,
                    "color": "#DCDCDC",
                  },
                }),
      },
      transportOptions: EmptyTransportOptions(),
    );

    await pumpDriver(
      tester,
      driver,
    );

    ListView list = tester.widget(find.byKey(const ValueKey("list1")));

    expect(list.itemExtent, 100.0);

    await driver.updateTestAttributes("list1", {
      "type": 0,
      "itemExtent": 200.0,
    });

    await tester.pumpAndSettle();

    list = tester.widget(find.byKey(const ValueKey("list1")));

    expect(list.itemExtent, 200.0);
  });

  testWidgets(
      "Checking the correct creation and destruction of component controllers when scrolling in ListView.builder",
      (tester) async {
    final driver = DuitDriver.static(
      _createWidget(1),
      transportOptions: EmptyTransportOptions(),
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(
          driver: driver,
        ),
      ),
    );

    await tester.pumpAndSettle();

    final scroll = find.byType(Scrollable);
    final itemFirst = find.byKey(const ValueKey("1"));
    final itemLast = find.byKey(const ValueKey("10"));

    await tester.scrollUntilVisible(
      itemLast,
      1000,
      scrollable: scroll,
    );

    expect(itemLast, findsOneWidget);
    expect(driver.controllersCount == 10, false);

    await tester.scrollUntilVisible(
      itemFirst,
      -1000,
      scrollable: scroll,
    );

    expect(itemFirst, findsOneWidget);
    expect(driver.controllersCount == 10, false);
  });

  testWidgets(
      "Checking the correct creation and destruction of component controllers when scrolling in ListView.separated",
      (tester) async {
    final driver = DuitDriver.static(
      _createWidget(2),
      transportOptions: EmptyTransportOptions(),
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(
          driver: driver,
        ),
      ),
    );

    await tester.pumpAndSettle();

    final scroll = find.byType(Scrollable);
    final itemFirst = find.byKey(const ValueKey("1"));
    final itemLast = find.byKey(const ValueKey("10"));

    await tester.scrollUntilVisible(
      itemLast,
      1000,
      scrollable: scroll,
    );

    expect(itemLast, findsOneWidget);
    expect(driver.controllersCount == 10, false);

    await tester.scrollUntilVisible(
      itemFirst,
      -1000,
      scrollable: scroll,
    );

    expect(itemFirst, findsOneWidget);
    expect(driver.controllersCount == 10, false);
  });
}
