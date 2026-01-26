import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitMergeSemantics tests",
    () {
      testWidgets(
        "must renders correctly with child",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "MergeSemantics",
              "id": "merge1",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "child": {
                "type": "Container",
                "id": "child",
                "controlled": false,
                "attributes": <String, dynamic>{
                  "width": 50.0,
                  "height": 50.0,
                  "color": "#DCDCDC",
                },
              },
            },
          );

          await pumpDriver(tester, driver.asInternalDriver);

          final mergeFinder = find.byKey(const ValueKey("merge1"));
          final childFinder = find.byKey(const ValueKey("child"));

          expect(mergeFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);

          final mergeWidget = tester
              .widget<MergeSemantics>(find.byKey(const ValueKey("merge1")));

          expect(mergeWidget, isNotNull);
        },
      );
    },
  );
}
