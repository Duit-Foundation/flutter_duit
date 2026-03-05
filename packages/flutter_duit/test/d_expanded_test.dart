import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group(
    "DuitExpanded tests",
    () {
      testWidgets(
        "must renders correctly",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                {
                  "type": "Expanded",
                  "controlled": false,
                  "id": "ex1",
                  "attributes": {
                    "flex": 1,
                  },
                  "child": {
                    "type": "Container",
                    "controlled": false,
                    "id": "con1",
                    "attributes": {
                      "color": Colors.black,
                    },
                  },
                },
                {
                  "type": "Expanded",
                  "controlled": true,
                  "id": "ex2",
                  "attributes": {
                    "flex": 2,
                  },
                  "child": {
                    "type": "Container",
                    "controlled": false,
                    "id": "con2",
                    "attributes": {
                      "color": Colors.green,
                    },
                  },
                },
                {
                  "type": "Expanded",
                  "controlled": false,
                  "id": "ex3",
                  "attributes": {
                    "flex": 1,
                  },
                  "child": {
                    "type": "Container",
                    "controlled": false,
                    "id": "con3",
                    "attributes": {
                      "color": Colors.red,
                    },
                  },
                },
              ],
            },
          );

          await tester.pumpWidget(
            MaterialApp(
              home: DuitViewHost.withDriver(driver: driver),
            ),
          );

          await tester.pumpAndSettle();

          var renderObject = tester
              .renderObject(find.byKey(const ValueKey("con1"))) as RenderBox;
          var renderObject2 = tester
              .renderObject(find.byKey(const ValueKey("con2"))) as RenderBox;
          var renderObject3 = tester
              .renderObject(find.byKey(const ValueKey("con3"))) as RenderBox;

          //check elements width witn initial flex values
          expect(renderObject.size.width, 200);
          expect(renderObject2.size.width, 400);
          expect(renderObject3.size.width, 200);

          await driver.asInternalDriver.updateAttributes("ex2", {
            "flex": 6,
          });

          await tester.pumpAndSettle();

          renderObject = tester.renderObject(find.byKey(const ValueKey("con1")))
              as RenderBox;
          renderObject2 = tester
              .renderObject(find.byKey(const ValueKey("con2"))) as RenderBox;
          renderObject3 = tester
              .renderObject(find.byKey(const ValueKey("con3"))) as RenderBox;

          //check elements width witn updated flex values
          expect(renderObject.size.width, 100);
          expect(renderObject2.size.width, 600);
          expect(renderObject3.size.width, 100);
        },
      );
    },
  );
}
