import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/component_template.dart";
import "utils.dart";

void main() {
  setUpAll(
    () async {
      await DuitRegistry.initialize();

      await DuitRegistry.registerComponents([componentTemplate]);
    },
  );

  group("DuitComponent widget tests", () {
    testWidgets("must merge with data correctly", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "x",
          "data": componentTemplateData,
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final cont1 = find.byKey(const Key("container1"));
      expect(cont1, findsOneWidget);
    });

    testWidgets("must use default value", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "x",
          "data": componentTemplateData2,
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final containerWithDefaultColorValue =
          find.byKey(const Key("container2"));
      expect(containerWithDefaultColorValue, findsOneWidget);
      expect(
        (tester.firstWidget(containerWithDefaultColorValue) as Container).color,
        const Color.fromRGBO(220, 220, 220, 1),
      );
    });

    testWidgets("must return empty view when tag is invalid", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "invalid_tag",
          "data": componentTemplateData2,
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final emptyWidget = find.byType(SizedBox);
      expect(emptyWidget, findsOneWidget);
    });

    testWidgets("must update component state", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "testId",
          "controlled": true,
          "tag": "x",
          "data": componentTemplateData,
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await driver.updateAttributes(
        "testId",
        componentUpdateTemplateData,
      );

      await tester.pumpAndSettle();

      final container = find.byType(Container);

      expect(container, findsWidgets);

      final fCont = container.first.evaluate().first.widget as Container;

      expect(fCont.color, const Color.fromRGBO(220, 220, 220, 1));
    });

    testWidgets("must register embedded component", (tester) async {
      final driver = DuitDriver.static(
        {
          "embedded": [
            componentTemplate2,
          ],
          "type": "Column",
          "id": "column1",
          "controlled": false,
          "children": [
            {
              "type": "Component",
              "id": "testId1",
              "controlled": true,
              "tag": "x",
              "data": componentTemplateData,
            },
            {
              "type": "Component",
              "id": "testId2",
              "controlled": true,
              "tag": "y",
              "data": componentTemplateData,
            }
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
          ),
        ),
      );

      await tester.pumpAndSettle();

      final container = find.byKey(const ValueKey("target_container"));

      expect(container, findsWidgets);
    });

    testWidgets("instances must be independent (no sticky state)",
        (tester) async {
      // First instance with full data
      var driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "compA",
          "tag": "x",
          "data": {
            "secColor": [
              255,
              255,
              255,
              1,
            ],
            "mainColor": "#075eeb",
          }, // both mainColor and secColor
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver, const ValueKey("iter1"));

      final containerNested1 =
          tester.firstWidget(find.byKey(const Key("container2"))) as Container;

      expect(containerNested1.color, const Color.fromRGBO(255, 255, 255, 1));

      // Now render second instance with missing secColor -> should use default
      final driver2 = DuitDriver.static(
        {
          "type": "Component",
          "id": "compB",
          "tag": "x",
          "data": {
            "mainColor": "#fcba03",
          }, // only mainColor
        },
        transportOptions: EmptyTransportOptions(),
      );

      await pumpDriver(tester, driver2, const ValueKey("iter2"));

      final containerNested2 =
          tester.firstWidget(find.byKey(const Key("container2"))) as Container;

      expect(containerNested2.color, const Color(0xffdcdcdc));
    });

    testWidgets(
        "writeOps path for children index is applied (embedded component)",
        (tester) async {
      final driver = DuitDriver.static(
        {
          "embedded": [componentTemplate2],
          "type": "Column",
          "id": "column1",
          "controlled": false,
          "children": [
            {
              "type": "Component",
              "id": "child1",
              "controlled": true,
              "tag": "y",
              "data":
                  const <String, dynamic>{}, // no data -> default must be used
            }
          ],
        },
        transportOptions: EmptyTransportOptions(),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(driver: driver),
        ),
      );
      await tester.pumpAndSettle();

      final target = find.byKey(const ValueKey("target_container"));
      expect(target, findsOneWidget);
      final color = (tester.firstWidget(target) as Container).color;
      expect(color, const Color.fromRGBO(220, 220, 220, 1));
    });
  });
}
