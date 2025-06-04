import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    'type': 'Offstage',
    'id': 'offstage_test',
    'controlled': false,
    'attributes' : {
      'offstage': true
    },
    'child': {
      'type': 'Container',
      'id': 'con',
      'controlled': false,
      'attributes' : {
        'color': '#DCDCDC',
        'width': 50,
        'height': 50
      }
    }
  };
}

void main() {
  group('DuitOffstage widget tests', () {
    testWidgets('check widget', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey('offstage_test'));

      expect(widget, findsOneWidget);
    });
  });
}
