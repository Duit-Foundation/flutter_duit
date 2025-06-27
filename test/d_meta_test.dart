import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_duit/src/utils/meta_data.dart';

import 'utils.dart';

void main() {
  group(
    "DuitMetaWidget tests",
    () {
      testWidgets(
        "must provide meta to subtree and update it",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Meta",
              "id": "meta1",
              "controlled": true,
              "attributes": {
                "value": {
                  "foo": "bar",
                }
              },
              "child": {
                "type": "Container",
                "id": "container1",
                "controlled": false,
                "attributes": {},
                "child": {
                  "type": "Text",
                  "id": "text1",
                  "controlled": false,
                  "attributes": {
                    "data": "text",
                  }
                }
              }
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          var context = tester.element(find.byType(Container));

          var meta = DuitMetaData.maybeOf(context);

          var metaValue = meta!.value["value"];
          expect(metaValue, isNotNull);
          expect(metaValue["foo"], "bar");

          await driver.updateTestAttributes(
            "meta1",
            {
              "value": {"foo": "baz", "num": 42}
            },
          );

          await tester.pumpAndSettle();

          context = tester.element(find.byType(Container));

          meta = DuitMetaData.maybeOf(context);

          metaValue = meta!.value["value"];
          expect(metaValue, isNotNull);
          expect(metaValue["foo"], "baz");
          expect(metaValue["num"], 42);
        },
      );
    },
  );
}
