import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets(
    "SliverToBoxAdapter test",
    (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "CustomScrollView",
          "id": "custom_view",
          "controlled": false,
          "attributes": {},
          "children": [
            {
              "type": "SliverToBoxAdapter",
              "id": "sliver1",
              "controlled": false,
              "child": {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Some text",
                  "style": {
                    "color": "#DCDCDC",
                    "fontSize": 64.0,
                    "fontWeight": 700,
                  }
                },
              },
            },
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(
        tester,
        driver,
      );

      expect(find.byKey(const ValueKey("text")), findsOneWidget);
    },
  );
}
