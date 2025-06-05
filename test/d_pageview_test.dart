import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    "controlled": true,
    "id": "87b54621-ac6d-42c3-8d1f-397e3bd63bca",
    "type": "PageView",
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
      await DuitRegistry.configure();

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
      "Checking the correct creation and destruction of component controllers when scrolling in PageView.builder",
      (tester) async {
    final driver = DuitDriver.static(
      _createWidget(),
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

    expect(find.byKey(ValueKey('1')), findsOneWidget);
    expect(find.byKey(ValueKey('10')), findsNothing);

    for (int i = 0; i < 10; i++) {
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
    }

    for (int i = 0; i < 10; i++) {
      await tester.drag(find.byType(PageView), const Offset(400, 0));
      await tester.pumpAndSettle();
    }

    expect(find.byKey(ValueKey('1')), findsOneWidget);
  });
}
