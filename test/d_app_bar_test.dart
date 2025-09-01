import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget([bool controlled = true]) {
  return {
    "type": "AppBar",
    "id": "appBarId",
    "controlled": controlled,
    "children": [
      {
        "type": "Text",
        "id": "title",
        "controlled": false,
        "attributes": {
          "data": "Title",
          "style": {
            "color": "#000000",
            "fontSize": 20.0,
            "fontWeight": 500,
          },
        },
      },
      {
        "type": "Text",
        "id": "leading",
        "controlled": false,
        "attributes": {
          "data": "Leading",
          "style": {
            "color": "#000000",
            "fontSize": 20.0,
            "fontWeight": 500,
          },
        },
      },
      null, //flexibleSpace
      null, //bottom
      {
        "type": "Text",
        "id": "action1",
        "controlled": false,
        "attributes": {
          "data": "Action",
          "style": {
            "color": "#000000",
            "fontSize": 20.0,
            "fontWeight": 500,
          },
        },
      },
    ],
    "attributes": {
      "backgroundColor": "#FF0000",
      "foregroundColor": "#FFFFFF",
      "elevation": 4.0,
      "centerTitle": true,
      "automaticallyImplyLeading": true,
      "toolbarHeight": 56.0,
      "leadingWidth": 56.0,
      "titleSpacing": 16.0,
      "bottomOpacity": 1.0,
      "toolbarOpacity": 1.0,
    },
  };
}

void main() {
  group("DuitAppBar widget tests", () {
    testWidgets(
      "must build widget with default attributes",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(),
                  transportOptions: EmptyTransportOptions(),
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final appBar = find.byKey(const ValueKey("appBarId"));
        expect(appBar, findsOneWidget);

        final appBarWidget = tester.widget<AppBar>(appBar);
        expect(appBarWidget.backgroundColor, const Color(0xFFFF0000));
        expect(appBarWidget.foregroundColor, const Color(0xFFFFFFFF));
        expect(appBarWidget.elevation, 4.0);
        expect(appBarWidget.centerTitle, true);
        expect(appBarWidget.automaticallyImplyLeading, true);
        expect(appBarWidget.toolbarHeight, 56.0);
        expect(appBarWidget.leadingWidth, 56.0);
        expect(appBarWidget.titleSpacing, 16.0);
        expect(appBarWidget.bottomOpacity, 1.0);
        expect(appBarWidget.toolbarOpacity, 1.0);
      },
    );

    testWidgets("must update widget attributes", (tester) async {
      final driver = DuitDriver.static(
        _createWidget(true),
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: driver,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await driver.updateTestAttributes("appBarId", {
        "backgroundColor": "#00FF00",
        "elevation": 8.0,
        "centerTitle": false,
        "toolbarHeight": 64.0,
      });

      await tester.pumpAndSettle();

      final appBar = find.byKey(const ValueKey("appBarId"));
      final appBarWidget = tester.widget<AppBar>(appBar);

      expect(appBarWidget.backgroundColor, const Color(0xFF00FF00));
      expect(appBarWidget.elevation, 8.0);
      expect(appBarWidget.centerTitle, false);
      expect(appBarWidget.toolbarHeight, 64.0);
    });

    testWidgets("must render title, leading and actions", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: DuitDriver.static(
                _createWidget(),
                transportOptions: EmptyTransportOptions(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final appBarWidget = tester.widget<AppBar>(
        find.byKey(
          const ValueKey("appBarId"),
        ),
      );

      expect(appBarWidget.title, isNotNull);
      expect(appBarWidget.leading, isNotNull);
      expect(appBarWidget.actions, isNotNull);
      expect(appBarWidget.flexibleSpace, isNull);
      expect(appBarWidget.bottom, isNull);
    });
  });
}
