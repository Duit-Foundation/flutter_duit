import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

double getFateTransitionOpacity(WidgetTester tester, Finder finder) {
  return tester
      .widget<FadeTransition>(
        find.ancestor(
          of: finder,
          matching: find.byType(FadeTransition),
        ),
      )
      .opacity
      .value;
}

double getOpacity(WidgetTester tester, Finder finder) {
  return tester
      .widget<Opacity>(
        find.ancestor(
          of: finder,
          matching: find.byType(Opacity),
        ),
      )
      .opacity;
}

String generateHexColor(int index) {
  final rng = Random(index);
  final randomNumber = rng.nextInt(0x1000000); // 0x1000000 == 16777216
  return '#${randomNumber.toRadixString(16).padLeft(6, '0')}';
}

Future<void> pumpDriver(
  WidgetTester tester,
  UIDriver driver, [
  Key? key,
  SliverGridDelegatesRegistry? sliverGridDelegatesRegistry,
]) async {
  await tester.pumpWidget(
    MaterialApp(
      key: key,
      home: Material(
        child: DuitViewHost(
          driver: driver,
          sliverGridDelegatesRegistry: sliverGridDelegatesRegistry ?? const {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
