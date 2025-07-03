import 'package:flutter/widgets.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group(
    'DuitCarouselView tests',
    () {
      final arr = [];

      for (var i = 0; i < 100; i++) {
        arr.add({
          "type": "Container",
          "controlled": false,
          "id": i.toString(),
          "attributes": {
            "color": generateHexColor(i),
          },
        });
      }

      testWidgets(
        "must renders with default props",
        (tester) async {
          const extent = 240.0;

          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car",
              "children": arr,
              "attributes": {
                "constructor": "common",
                "itemExtent": extent,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car")), findsOneWidget);

          final scrollable = find.byType(Scrollable);

          await tester.scrollUntilVisible(
            find.byKey(const ValueKey("99")),
            extent * arr.length,
            scrollable: scrollable,
          );

          expect(find.byKey(const ValueKey("99")), findsOneWidget);
        },
      );

      testWidgets(
        "must update attributes",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": true,
              "id": "car_ctrl",
              "children": [
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "0",
                  "attributes": {"color": "#FF0000"},
                },
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "1",
                  "attributes": {"color": "#00FF00"},
                },
              ],
              "attributes": {
                "constructor": "common",
                "itemExtent": 100.0,
                "backgroundColor": "#FFFFFF",
                "elevation": 2.0,
                "shape": {
                  "type": "RoundedRectangleBorder",
                  "borderRadius": {
                    "radius": 8.0,
                  },
                },
                "itemSnapping": true,
                "shrinkExtent": 0.0,
                "scrollDirection": "vertical",
                "enableSplash": false,
                "reverse": true,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car_ctrl")), findsOneWidget);
          expect(find.byKey(const ValueKey("0")), findsOneWidget);
          expect(find.byKey(const ValueKey("1")), findsOneWidget);
        },
      );

      testWidgets(
        "must render with empty children",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car_empty",
              "children": [],
              "attributes": {
                "constructor": "common",
                "itemExtent": 100.0,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car_empty")), findsOneWidget);
        },
      );

      testWidgets(
        "must render with one child",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car_one",
              "children": [
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "only",
                  "attributes": {"color": "#123456"},
                },
              ],
              "attributes": {
                "constructor": "common",
                "itemExtent": 100.0,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car_one")), findsOneWidget);
          expect(find.byKey(const ValueKey("only")), findsOneWidget);
        },
      );

      testWidgets(
        "must render with reverse and vertical scroll",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car_vert",
              "children": [
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "a",
                  "attributes": {"color": "#111111"},
                },
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "b",
                  "attributes": {"color": "#222222"},
                },
              ],
              "attributes": {
                "constructor": "common",
                "itemExtent": 100.0,
                "scrollDirection": "vertical",
                "reverse": true,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car_vert")), findsOneWidget);
        },
      );

      testWidgets(
        "must render with itemSnapping and shrinkExtent",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car_snap",
              "children": [
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "snap1",
                  "attributes": {"color": "#333333"},
                },
                {
                  "type": "Container",
                  "controlled": false,
                  "id": "snap2",
                  "attributes": {"color": "#444444"},
                },
              ],
              "attributes": {
                "constructor": "common",
                "itemExtent": 100.0,
                "itemSnapping": true,
                "shrinkExtent": 50.0,
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(find.byKey(const ValueKey("car_snap")), findsOneWidget);
        },
      );
    },
  );
}
