import "package:alchemist/alchemist.dart";
import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/empty.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/component_template.dart";

void main() {
  DuitRegistry.registerComponents([componentTemplate]);

  group("Component", () {
    testWidgets("Component merge with data", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "x",
          "data": componentTemplateData,
        },
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
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

    testWidgets("Component use default value", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "x",
          "data": componentTemplateData2,
        },
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
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
          (tester.firstWidget(containerWithDefaultColorValue) as Container)
              .color,
          ColorUtils.tryParseColor("#DCDCDC"));
    });

    testWidgets("Component have no description", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "comp1",
          "tag": "invalid_tag",
          "data": componentTemplateData2,
        },
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
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

      final emptyWidget = find.byType(DuitEmptyView);
      expect(emptyWidget, findsOneWidget);
    });
  });

  goldenTest(
    "Component goldens",
    fileName: "d_component",
    builder: () => GoldenTestGroup(children: [
      GoldenTestScenario(
        name: "Component base scenario",
        child: DuitViewHost(
          driver: DuitDriver.static(
            {
              "type": "Component",
              "id": "comp1",
              "tag": "x",
              "data": componentTemplateData,
            },
            transportOptions: HttpTransportOptions(),
            enableDevMetrics: false,
          ),
        ),
      ),
      GoldenTestScenario(
        name: "Component with default value",
        child: DuitViewHost(
          driver: DuitDriver.static(
            {
              "type": "Component",
              "id": "comp1",
              "tag": "x",
              "data": componentTemplateData2,
            },
            transportOptions: HttpTransportOptions(),
            enableDevMetrics: false,
          ),
        ),
      ),
      GoldenTestScenario(
        name: "Component with non existent tag",
        child: DuitViewHost(
          driver: DuitDriver.static(
            {
              "type": "Component",
              "id": "comp1",
              "tag": "invalid_tag",
              "data": componentTemplateData2,
            },
            transportOptions: HttpTransportOptions(),
            enableDevMetrics: false,
          ),
        ),
      ),
    ]),
  );
}
