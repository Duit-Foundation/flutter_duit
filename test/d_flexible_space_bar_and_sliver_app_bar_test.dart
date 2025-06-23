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
          "attributes": {
            "title": {
              "type": "Text",
              "id": "sliverTitle",
              "controlled": false,
              "attributes": {
                "data": "Sliver App Bar",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 20.0,
                  "fontWeight": 500,
                }
              }
            },
            "leading": {
              "type": "Text",
              "id": "sliverLeading",
              "controlled": false,
              "attributes": {
                "data": "←",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 24.0,
                  "fontWeight": 400,
                }
              }
            },
            "actions": [
              {
                "type": "Text",
                "id": "sliverAction1",
                "controlled": false,
                "attributes": {
                  "data": "⚙️",
                  "style": {
                    "color": "#FFFFFF",
                    "fontSize": 20.0,
                  }
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
                  }
                },
              },
            ],
            "flexibleSpace": {
              "type": "FlexibleSpaceBar",
              "id": "flexibleSpaceBarId",
              "controlled": controlledFlexibleSpaceBar,
              "attributes": {
                "title": {
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
                "background": {
                  "type": "Container",
                  "id": "background",
                  "controlled": false,
                  "attributes": {
                    "color": "#2196F3",
                    "child": {
                      "type": "Text",
                      "id": "backgroundText",
                      "controlled": false,
                      "attributes": {
                        "data": "Background",
                        "style": {
                          "color": "#FFFFFF",
                          "fontSize": 16.0,
                        }
                      }
                    }
                  }
                },
                "centerTitle": true,
                "expandedTitleScale": 1.5,
                "collapseMode": "parallax",
                "stretchModes": ["zoomBackground", "fadeTitle"],
                "titlePadding": {
                  "left": 16.0,
                  "top": 16.0,
                  "right": 16.0,
                  "bottom": 16.0,
                }
              },
            },
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
          "attributes": <String, dynamic>{},
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
          enableDevMetrics: false,
        );

        await pumpDriver(tester, driver);

        final sliverAppBar = find.byKey(const ValueKey("sliverAppBarId"));
        expect(sliverAppBar, findsOneWidget);

        final flexibleSpaceBar =
            find.byKey(const ValueKey("flexibleSpaceBarId"));
        expect(flexibleSpaceBar, findsOneWidget);
      },
    );

    testWidgets(
      "FlexibleSpaceBar must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(
            controlledFlexibleSpaceBar: true,
          ),
          transportOptions: HttpTransportOptions(),
          enableDevMetrics: false,
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

        await driver.updateTestAttributes("flexibleSpaceBarId", {
          "centerTitle": false,
          "expandedTitleScale": 2.0,
          "collapseMode": "pin",
          "stretchModes": ["blurBackground"],
          "titlePadding": [8.0, 8.0, 8.0, 8.0]
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
            flexibleSpaceBarWidget.stretchModes, [StretchMode.blurBackground]);
        expect(flexibleSpaceBarWidget.titlePadding, const EdgeInsets.all(8.0));
      },
    );

    testWidgets(
      "SliverAppBar must update attributes correctly",
      (tester) async {
        final driver = DuitDriver.static(
          _createWidget(),
          transportOptions: EmptyTransportOptions(),
          enableDevMetrics: false,
        );

        await pumpDriver(tester, driver);

        await tester.pumpAndSettle();

        await driver.updateTestAttributes("sliverAppBarId", {
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
          enableDevMetrics: false,
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
          await driver.updateTestAttributes("sliverAppBarId", testCase);

          await tester.pumpAndSettle();

          // Check that the widget is still rendered
          expect(find.text("Sliver App Bar"), findsOneWidget);
          expect(find.text("←"), findsOneWidget);
        }
      },
    );
  });
}
