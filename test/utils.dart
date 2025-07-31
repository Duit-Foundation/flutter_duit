import "dart:async";
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

final class MockTransport extends Transport {
  final Map<String, dynamic> mustReturnThis;

  MockTransport(
    super.url,
    this.mustReturnThis,
  );

  @override
  Future<Map<String, dynamic>?> connect({Map<String, dynamic>? initialData}) {
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  FutureOr<Map<String, dynamic>?> execute(
    ServerAction action,
    Map<String, dynamic> payload,
  ) async {
    return mustReturnThis;
  }

  @override
  FutureOr<Map<String, dynamic>?> request(
    String url,
    Map<String, dynamic> meta,
    Map<String, dynamic> body, [
    Map<String, dynamic>? returnValue,
  ]) async {
    await Future.delayed(const Duration(seconds: 1));
    return mustReturnThis;
  }
}

extension TransportExtension on UIDriver {
  void applyMockTransport(dynamic mustReturnThis) {
    transport = MockTransport("", mustReturnThis);
  }
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
