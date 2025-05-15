import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

// {
//   "type": "CustomScrollView",
//   "id": "custom_view",
//   "contolled": false,
//   "attributes": {},
//   "children": [
//     {
//       "type": "SliverFillViewport",
//       "id": "sliver1",
//       "controlled": false,
//       "attributes": {
//         "viewportFraction": 0.1,
//         "isBuilderDelegate": false,
//         "childObjects": [
//           {
//             "type": "Container",
//             "id": "1",
//             "controlled": false,
//             "attributes": {
//               "color": "#FF0000",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "2",
//             "controlled": false,
//             "attributes": {
//               "color": "#4287f5",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "3",
//             "controlled": false,
//             "attributes": {
//               "color": "#f5aa42",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "4",
//             "controlled": false,
//             "attributes": {
//               "color": "#DCDCDC",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "44dg",
//             "controlled": false,
//             "attributes": {
//               "color": "#FF0000",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "4vfgeer3",
//             "controlled": false,
//             "attributes": {
//               "color": "#DCDCDC",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "4bnnvcc",
//             "controlled": false,
//             "attributes": {
//               "color": "#FF0000",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "`zxc4",
//             "controlled": false,
//             "attributes": {
//               "color": "#DCDCDC",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "4bvbz",
//             "controlled": false,
//             "attributes": {
//               "color": "#FF0000",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "4zx",
//             "controlled": false,
//             "attributes": {
//               "color": "#DCDCDC",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "cv4",
//             "controlled": false,
//             "attributes": {
//               "color": "#FF0000",
//             },
//           },
//           {
//             "type": "Container",
//             "id": "dsf4",
//             "controlled": false,
//             "attributes": {
//               "color": "#DCDCDC",
//             },
//           },
//         ],
//       },
//       "children": [
//         {
//           "type": "Container",
//           "id": "1",
//           "controlled": false,
//           "attributes": {
//             "color": "#FF0000",
//           },
//         },
//         {
//           "type": "Container",
//           "id": "2",
//           "controlled": false,
//           "attributes": {
//             "color": "#4287f5",
//           },
//         },
//         {
//           "type": "Container",
//           "id": "3",
//           "controlled": false,
//           "attributes": {
//             "color": "#f5aa42",
//           },
//         },
//         {
//           "type": "Container",
//           "id": "4",
//           "controlled": false,
//           "attributes": {
//             "color": "#FF0000",
//           },
//         }
//       ],
//     },
//   ],
// },

void main() {
  group(
    "DuitFillViewport",
    () {
      testWidgets(
        "must renders correctry",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": false,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": false,
                  },
                  "children": List.generate(
                    10,
                    (i) {
                      return {
                        "type": "Container",
                        "id": i.toString(),
                        "controlled": false,
                        "attributes": {
                          "color": generateHexColor(i),
                        },
                      };
                    },
                  ),
                }
              ],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );
    },
  );

  group(
    "DuitControllerFillViewport",
    () {
      testWidgets(
        "must renders correctry (simple delegate)",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": true,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": false,
                  },
                  "children": List.generate(
                    10,
                    (i) {
                      return {
                        "type": "Container",
                        "id": i.toString(),
                        "controlled": false,
                        "attributes": {
                          "color": generateHexColor(i),
                        },
                      };
                    },
                  ),
                }
              ],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);
          expect(find.byKey(const ValueKey("0")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            1000,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );

      testWidgets(
        "must renders correctry (builder delegate)",
        (tester) async {
          final children = List.generate(
            10,
            (i) {
              return {
                "type": "Container",
                "id": i.toString(),
                "controlled": false,
                "attributes": {
                  "color": generateHexColor(i),
                },
              } as Map<String, dynamic>;
            },
          );

          final driver = DuitDriver.static(
            {
              "type": "CustomScrollView",
              "id": "custom_view",
              "contolled": false,
              "attributes": {},
              "children": [
                {
                  "type": "SliverFillViewport",
                  "id": "viewport_sliver",
                  "controlled": true,
                  "attributes": {
                    "viewportFraction": 0.8,
                    "isBuilderDelegate": true,
                    "childObjects": children,
                    "childCount": 10,
                  },
                }
              ],
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("viewport_sliver")), findsOneWidget);
          expect(find.byKey(const ValueKey("0")), findsOneWidget);

          final scroll = find.byType(Scrollable);

          final itemLast = find.byKey(const ValueKey("9"));

          await tester.scrollUntilVisible(
            itemLast,
            500,
            scrollable: scroll,
          );

          expect(find.byKey(const ValueKey("9")), findsOneWidget);
        },
      );
    },
  );
}
