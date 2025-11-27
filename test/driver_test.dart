import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

class _StubTransport extends Mock implements Transport {}

class _StubStreamTransport extends Mock implements Transport, Streamer {}

final class _StubScriptRunner extends ScriptRunner<dynamic> implements Mock {
  _StubScriptRunner()
      : super(
          runnerOptions: null,
        );
  String x = "";
  @override
  Future<void> eval(String sourceCode) async {
    x = "${sourceCode}_evaluated";
  }

  @override
  Future<void> initWithTransport(Transport transport) async {}

  @override
  Future<Map<String, dynamic>?> runScript(
    String functionName, {
    String? url,
    Map<String, dynamic>? meta,
    Map<String, dynamic>? body,
  }) async =>
      {};
}

final _stubTransport = _StubTransport();
final _stubStreamTransport = _StubStreamTransport();
final _stubScriptRunner = _StubScriptRunner();

extension on UIDriver {
  void applyTransport() {
    transport = _stubTransport;
  }

  void applyStreamTransport() {
    transport = _stubStreamTransport;
  }

  void applyScriptRunner() {
    scriptRunner = _stubScriptRunner;
  }
}

void main() {
  test(
    "must handle transport returnerd content",
    () async {
      when(_stubTransport.connect).thenAnswer(
        (_) => Future.value(
          <String, dynamic>{
            "type": "Text",
            "id": "id",
            "attributes": {
              "data": "Text",
            },
          },
        ),
      );

      final driver = DuitDriver(
        "",
        transportOptions: EmptyTransportOptions(),
      )..applyTransport();

      driver.eventStream.listen((e) {
        expect(e, isA<UIDriverViewEvent>());
        return;
      });

      await driver.init();
    },
  );

  test(
    "must handle stream transport returnerd content",
    () async {
      when(_stubStreamTransport.connect).thenAnswer(
        (_) => Future.value(
          <String, dynamic>{
            "type": "Text",
            "id": "id",
            "attributes": {
              "data": "Text",
            },
          },
        ),
      );

      when(() => _stubStreamTransport.eventStream)
          .thenAnswer((_) => const Stream.empty());

      final driver = DuitDriver(
        "",
        transportOptions: EmptyTransportOptions(),
      )..applyStreamTransport();

      driver.eventStream.listen((e) {
        expect(e, isA<UIDriverViewEvent>());
        return;
      });

      await driver.init();
    },
  );

  test(
    "must dispatch script evaluation to script runner",
    () async {
      final driver = DuitDriver(
        "",
        transportOptions: EmptyTransportOptions(),
      )..applyScriptRunner();

      await driver.init();
      await driver.evalScript("script");

      expect(_stubScriptRunner.x, "script_evaluated");
    },
  );

  testWidgets(
    "driver must build widget",
    (tester) async {
      when(_stubTransport.connect).thenAnswer(
        (_) => Future.value(
          <String, dynamic>{
            "type": "Text",
            "id": "id",
            "attributes": {
              "data": "Text",
            },
          },
        ),
      );

      final driver = DuitDriver(
        "",
        transportOptions: EmptyTransportOptions(),
      )..applyTransport();

      await driver.init();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: driver.build() ?? const SizedBox(),
        ),
      );

      driver.notifyWidgetDisplayStateChanged("", 1);

      final text = find.text("Text");

      expect(text, findsOneWidget);
      expect(driver.isWidgetReady(""), true);
    },
  );
}
