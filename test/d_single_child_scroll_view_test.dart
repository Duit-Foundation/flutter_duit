import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget1() {
  return {
    "type": "SingleChildScrollView",
    "attributes": {},
    "controlled": false,
    "id": "scr",
    "child": {
      "type": "Column",
      "attributes": {},
      "controlled": false,
      "id": "col",
      "children": List.generate(
        100,
        (i) => {
          "type": "Container",
          "id": "c$i",
          "controlled": i % 2 == 0 ? true : false,
          "attributes": {
            "height": "150",
            "width": "150",
            "color": "#DCDCDC",
          },
        } as Map<String, dynamic>,
      ),
    },
  };
}

void main() {
  testWidgets('SingleChildScrollView scrolls correctly',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      _createWidget1(),
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

    expect(driver.controllersCount, 50);

    final scrollView = find.byType(Scrollable);

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey("c50")),
      150.0,
      scrollable: scrollView,
    );
    await tester.pumpAndSettle();

    expect(scrollView, findsOneWidget);
    expect(find.byKey(const ValueKey("c50")), findsOneWidget);
  });

  testWidgets('SingleChildScrollView scrolls horizontally',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      {
        "type": "SingleChildScrollView",
        "attributes": {"scrollDirection": "horizontal"},
        "controlled": false,
        "id": "scr_h",
        "child": {
          "type": "Row",
          "attributes": {},
          "controlled": false,
          "id": "row_h",
          "children": List.generate(
            30,
            (i) => {
              "type": "Container",
              "id": "hc$i",
              "controlled": false,
              "attributes": {
                "width": "100",
                "height": "50",
                "color": "#DCDCDC",
              },
            },
          ),
        },
      },
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(driver: driver),
      ),
    );
    await tester.pumpAndSettle();
    final scrollView = find.byType(Scrollable);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey("hc29")),
      100.0,
      scrollable: scrollView,
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey("hc29")), findsOneWidget);
  });

  testWidgets('SingleChildScrollView reverse: true',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      {
        "type": "SingleChildScrollView",
        "attributes": {"reverse": true},
        "controlled": false,
        "id": "scr_r",
        "child": {
          "type": "Column",
          "attributes": {},
          "controlled": false,
          "id": "col_r",
          "children": List.generate(
            10,
            (i) => {
              "type": "Container",
              "id": "rc$i",
              "controlled": false,
              "attributes": {
                "height": "50",
                "width": "50",
                "color": "#DCDCDC",
              },
            },
          ),
        },
      },
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(driver: driver),
      ),
    );
    await tester.pumpAndSettle();
    final scrollView = find.byType(Scrollable);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey("rc0")),
      50.0,
      scrollable: scrollView,
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey("rc0")), findsOneWidget);
  });

  testWidgets('SingleChildScrollView with padding',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      {
        "type": "SingleChildScrollView",
        "attributes": {
          "padding": [20, 10, 20, 10]
        },
        "controlled": false,
        "id": "scr_p",
        "child": {
          "type": "Container",
          "id": "pc1",
          "controlled": false,
          "attributes": {
            "height": "50",
            "width": "50",
            "color": "#DCDCDC",
          },
        },
      },
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(driver: driver),
      ),
    );
    await tester.pumpAndSettle();
    final box =
        tester.renderObject<RenderBox>(find.byKey(const ValueKey("pc1")));
    final offset = box.localToGlobal(Offset.zero);
    expect(offset.dx, greaterThanOrEqualTo(20));
    expect(offset.dy, greaterThanOrEqualTo(10));
  });

  testWidgets('SingleChildScrollView with NeverScrollableScrollPhysics',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      {
        "type": "SingleChildScrollView",
        "attributes": {"physics": "NeverScrollableScrollPhysics"},
        "controlled": false,
        "id": "scr_np",
        "child": {
          "type": "Column",
          "attributes": {},
          "controlled": false,
          "id": "col_np",
          "children": List.generate(
            20,
            (i) => {
              "type": "Container",
              "id": "npc$i",
              "controlled": false,
              "attributes": {
                "height": "50",
                "width": "50",
                "color": "#DCDCDC",
              },
            },
          ),
        },
      },
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(driver: driver),
      ),
    );
    await tester.pumpAndSettle();
    final scrollView = find.byType(Scrollable);
    final before = tester.getTopLeft(find.byKey(const ValueKey("npc0"))).dy;
    await tester.drag(scrollView, const Offset(0, -500));
    await tester.pumpAndSettle();
    final after = tester.getTopLeft(find.byKey(const ValueKey("npc0"))).dy;
    expect(before, equals(after));
  });

  testWidgets('SingleChildScrollView controlled: updates padding',
      (WidgetTester tester) async {
    final driver = DuitDriver.static(
      {
        "type": "SingleChildScrollView",
        "id": "scr_ctrl",
        "controlled": true,
        "attributes": {
          "padding": [0, 0, 0, 0],
        },
        "child": {
          "type": "Container",
          "id": "ctrlc1",
          "controlled": false,
          "attributes": {
            "height": "50",
            "width": "50",
            "color": "#DCDCDC",
          },
        },
      },
      transportOptions: HttpTransportOptions(),
      enableDevMetrics: false,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost(driver: driver),
      ),
    );
    await tester.pumpAndSettle();
    var box =
        tester.renderObject<RenderBox>(find.byKey(const ValueKey("ctrlc1")));
    var offset = box.localToGlobal(Offset.zero);
    expect(offset.dx, 0);
    expect(offset.dy, 0);
    await driver.updateTestAttributes('scr_ctrl', {
      "padding": [30, 15, 0, 0]
    });
    await tester.pumpAndSettle();
    box = tester.renderObject<RenderBox>(find.byKey(const ValueKey("ctrlc1")));
    offset = box.localToGlobal(Offset.zero);
    expect(offset.dx, greaterThanOrEqualTo(30));
    expect(offset.dy, greaterThanOrEqualTo(15));
  });
}
