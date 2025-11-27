import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget({
  bool controlledFlexibleSpaceBar = true,
}) =>
    {
      "type": "CustomScrollView",
      "id": "customScrollViewId",
      "controlled": false,
      "attributes": {
        "scrollDirection": "vertical",
        "shrinkWrap": false,
      },
      "children": [
        //appbar
        {
          "type": "SliverAppBar",
          "id": "sliverAppBarId",
          "controlled": true,
          "children": [
            //title
            {
              "type": "Text",
              "id": "sliverTitle",
              "controlled": false,
              "attributes": {
                "data": "Sliver App Bar",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 20.0,
                  "fontWeight": 500,
                },
              },
            },
            //leading
            {
              "type": "Text",
              "id": "sliverLeading",
              "controlled": false,
              "attributes": {
                "data": "←",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 24.0,
                  "fontWeight": 400,
                },
              },
            },
            //flexibleSpace
            {
              "type": "FlexibleSpaceBar",
              "id": "flexibleSpaceBarId",
              "controlled": controlledFlexibleSpaceBar,
              "children": [
                {
                  "type": "Text",
                  "id": "title",
                  "controlled": false,
                  "attributes": {
                    "data": "Flexible Title",
                    "style": {
                      "color": "#FFFFFF",
                      "fontSize": 24.0,
                      "fontWeight": 600,
                    },
                  },
                },
                {
                  "type": "Container",
                  "id": "background",
                  "controlled": false,
                  "attributes": {
                    "color": "#2196F3",
                  },
                  "child": {
                    "type": "Text",
                    "id": "backgroundText",
                    "controlled": false,
                    "attributes": {
                      "data": "Background",
                      "style": {
                        "color": "#FFFFFF",
                        "fontSize": 16.0,
                      },
                    },
                  },
                },
              ],
              "attributes": {
                "centerTitle": true,
                "expandedTitleScale": 1.5,
                "collapseMode": "parallax",
                "stretchModes": ["zoomBackground", "fadeTitle"],
                "titlePadding": {
                  "left": 16.0,
                  "top": 16.0,
                  "right": 16.0,
                  "bottom": 16.0,
                },
              },
            },
            //bottom
            null,
            //actions
            {
              "type": "Text",
              "id": "sliverAction1",
              "controlled": false,
              "attributes": {
                "data": "⚙️",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 20.0,
                },
              },
            },
            {
              "type": "Text",
              "id": "sliverAction2",
              "controlled": false,
              "attributes": {
                "data": "🔍",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 20.0,
                },
              },
            },
          ],
          "attributes": {
            "backgroundColor": "#1976D2",
            "foregroundColor": "#FFFFFF",
            "elevation": 4.0,
            "floating": true,
            "pinned": true,
            "snap": false,
            "stretch": true,
            "expandedHeight": 200.0,
            "collapsedHeight": 56.0,
            "stretchTriggerOffset": 100.0,
            "forceElevated": false,
            "centerTitle": true,
            "automaticallyImplyLeading": true,
            "toolbarHeight": 56.0,
            "leadingWidth": 56.0,
            "titleSpacing": 16.0,
            "bottomOpacity": 1.0,
            "toolbarOpacity": 1.0,
            "forceMaterialTransparency": false,
            "primary": true,
            "excludeHeaderSemantics": false,
          },
        },
        {
          "type": "SliverToBoxAdapter",
          "id": "adatp",
          "controlled": false,
          "child": {
            "type": "Container",
            "id": "cont",
            "controlled": true,
            "attributes": {
              "color": "#000000",
              "width": 100.0,
              "height": 1000.0,
            },
          },
        },
      ],
    };

void main() {
  group("FlexibleSpaceBar and SliverAppBar widget tests", () {
    testWidgets(
      "FlexibleSpaceBar must build with all attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(
            controlledFlexibleSpaceBar: false,
          ),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        final sliverAppBar = find.byKey(const ValueKey("sliverAppBarId"));
        expect(sliverAppBar, findsOneWidget);

        final flexibleSpaceBar =
            find.byKey(const ValueKey("flexibleSpaceBarId"));
        expect(flexibleSpaceBar, findsOneWidget);

        final title = find.byKey(const ValueKey("title"));
        expect(title, findsOneWidget);

        final background = find.byKey(const ValueKey("background"));
        expect(background, findsOneWidget);

        final backgroundText = find.text("Background");
        expect(backgroundText, findsOneWidget);
      },
    );

    testWidgets(
      "FlexibleSpaceBar must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(
            controlledFlexibleSpaceBar: true,
          ),
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

        await driver.updateAttributes("flexibleSpaceBarId", {
          "centerTitle": false,
          "expandedTitleScale": 2.0,
          "collapseMode": "pin",
          "stretchModes": ["blurBackground"],
          "titlePadding": [8.0, 8.0, 8.0, 8.0],
        });

        await tester.pumpAndSettle();

        final flexibleSpaceBar =
            find.byKey(const ValueKey("flexibleSpaceBarId"));
        final flexibleSpaceBarWidget =
            tester.widget<FlexibleSpaceBar>(flexibleSpaceBar);

        expect(flexibleSpaceBarWidget.centerTitle, false);
        expect(flexibleSpaceBarWidget.expandedTitleScale, 2.0);
        expect(flexibleSpaceBarWidget.collapseMode, CollapseMode.pin);
        expect(
          flexibleSpaceBarWidget.stretchModes,
          [StretchMode.blurBackground],
        );
        expect(flexibleSpaceBarWidget.titlePadding, const EdgeInsets.all(8.0));
      },
    );

    testWidgets(
      "SliverAppBar must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        await tester.pumpAndSettle();

        await driver.updateAttributes("sliverAppBarId", {
          "backgroundColor": "#FF5722",
          "elevation": 8.0,
          "floating": false,
          "pinned": false,
          "snap": false, // Changed from true to false since floating is false
          "stretch": false,
          "expandedHeight": 150.0,
          "collapsedHeight": 64.0,
          "stretchTriggerOffset": 50.0,
          "forceElevated": true,
          "centerTitle": false,
          "toolbarHeight": 64.0,
          "leadingWidth": 64.0,
          "titleSpacing": 8.0,
        });

        await tester.pumpAndSettle();

        // Check that the widget is still rendered
        expect(find.text("Sliver App Bar"), findsOneWidget);
        expect(find.text("←"), findsOneWidget);
        expect(find.text("⚙️"), findsOneWidget);
        expect(find.text("🔍"), findsOneWidget);
      },
    );

    testWidgets(
      "SliverAppBar with different boolean properties must work correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(),
          transportOptions: EmptyTransportOptions(),
        );

        await pumpDriver(tester, driver);

        // Test different boolean combinations
        final testCases = [
          {"floating": true, "pinned": true, "snap": false, "stretch": true},
          {"floating": true, "pinned": false, "snap": true, "stretch": false},
          {"floating": false, "pinned": true, "snap": false, "stretch": false},
          {"floating": false, "pinned": false, "snap": false, "stretch": true},
        ];

        for (final testCase in testCases) {
          await driver.updateAttributes("sliverAppBarId", testCase);

          await tester.pumpAndSettle();

          // Check that the widget is still rendered
          expect(find.text("Sliver App Bar"), findsOneWidget);
          expect(find.text("←"), findsOneWidget);
        }
      },
    );
  });
}
