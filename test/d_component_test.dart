import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/empty.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/component_template.dart";

void main() {
  DuitRegistry.registerComponents([componentTemplate]);

  group("DuitComponent widget tests", () {
    testWidgets("check merge with data", (tester) async {
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

    testWidgets("check default value", (tester) async {
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
        (tester.firstWidget(containerWithDefaultColorValue) as Container).color,
        ColorUtils.tryParseColor("#DCDCDC"),
      );
    });

    testWidgets("check component without description", (tester) async {
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

    testWidgets("check component update process", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Component",
          "id": "testId",
          "controlled": true,
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

      await driver.updateTestAttributes(
        "testId",
        componentUpdateTemplateData,
      );

      await tester.pumpAndSettle();

      final container = find.byType(Container);

      expect(container, findsWidgets);

      final fCont = container.first.evaluate().first.widget as Container;

      expect(fCont.color, ColorUtils.tryParseColor("#DCDCDC"));
    });
  });
}
