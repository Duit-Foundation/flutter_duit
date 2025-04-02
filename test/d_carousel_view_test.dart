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
        "must throw exception for .weighted constructor",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "CarouselView",
              "controlled": false,
              "id": "car",
              "children": arr,
              "attributes": {
                "constructor": "weighted",
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(
            tester,
            driver,
          );

          expect(tester.takeException(), isA<UnimplementedError>());
        },
      );
    },
  );
}
