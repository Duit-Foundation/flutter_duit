import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "mocks/custom.dart";

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

final class CustomWidgetThemeToken extends ThemeToken {
  CustomWidgetThemeToken(Map<String, dynamic> themeData)
      : super(
          const {},
          themeData,
          exampleCustomWidget,
        );
}

final class MockThemeLoader implements ResourceLoader<DuitTheme> {
  final Map<String, dynamic> theme;

  const MockThemeLoader(this.theme);

  @override
  Future<DuitTheme> load() async {
    final tp = ThemePreprocessor(
      customWidgetTokenizer: (type, themeData) {
        final token = switch (type) {
          exampleCustomWidget => CustomWidgetThemeToken(themeData),
          _ => null,
        };

        return token;
      },
    );

    return tp.tokenize(theme);
  }
}

Future<void> pumpDriver(
  WidgetTester tester,
  UIDriver driver, [
  Key? key,
  SliverGridDelegatesRegistry? sliverGridDelegatesRegistry,
]) async {
  await tester.pumpWidget(
    Directionality(
      key: key,
      textDirection: TextDirection.ltr,
      child: DuitViewHost(
        driver: driver,
        sliverGridDelegatesRegistry: sliverGridDelegatesRegistry ?? const {},
      ),
    ),
  );
  await tester.pumpAndSettle();
}
