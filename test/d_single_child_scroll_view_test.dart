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
}
