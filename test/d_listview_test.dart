import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    "controlled": true,
    "id": "87b54621-ac6d-42c3-8d1f-397e3bd63bca",
    "type": "ListView",
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
        }
      ]);
    },
  );

  testWidgets(
      "Checking the correct creation and destruction of component controllers when scrolling in ListView.builder",
      (tester) async {
    final driver = DuitDriver.static(
      _createWidget(),
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
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
