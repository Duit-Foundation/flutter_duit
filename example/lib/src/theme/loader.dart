import 'package:dio/dio.dart';
import 'package:example/src/theme/custom_token.dart';
import 'package:example/src/theme/override_token.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class HttpThemeLoader implements ResourceLoader<DuitTheme> {
  final Dio dio;
  final String path;

  HttpThemeLoader(
    this.dio,
    this.path,
  );

  ThemeToken? _customTokenizer(
    String type,
    Map<String, dynamic> themeData,
  ) {
    switch (type) {
      case "ExampleCustomWidget":
        return CustomWidgetThemeToken(themeData);
    }

    return null;
  }

  ThemeToken _overrideWidgetTokenizer(
    String type,
    Map<String, dynamic> themeData,
  ) {
    switch (type) {
      case "Text":
        return OverrideTextThemeToken(themeData);
    }

    return const UnknownThemeToken();
  }

  @override
  Future<DuitTheme> load() async {
    final res = await dio.get(path);
    final tokenizer = ThemePreprocessor(
      customWidgetTokenizer: _customTokenizer,
      overrideWidgetTokenizer: _overrideWidgetTokenizer,
    );

    return tokenizer.tokenize(res.data);
  }
}
