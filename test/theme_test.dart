import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/ui/theme/preprocessor.dart";
import "package:flutter_duit/src/ui/theme/tokens.dart";
import "package:flutter_test/flutter_test.dart";

final class _SomeWidgetThemeToken extends ThemeToken {
  const _SomeWidgetThemeToken(
    Map<String, dynamic> data,
  ) : super(
          const {},
          data,
          'SomeCustomWidget',
        );
}

final class _OverridedTextThemeToken extends ThemeToken {
  const _OverridedTextThemeToken(
    Map<String, dynamic> data,
  ) : super(
          const {
            "data",
            "style",
          },
          data,
          'Text',
        );
}

void main() {
  setUpAll(() async {
    final proc = const DuitThemePreprocessor().tokenize(
      {
        "text_1": {
          "type": "Text",
          "data": {
            "textAlign": "center",
            "style": {
              "fontSize": 32.0,
              "color": "#FF0000",
            }
          }
        },
        "text_2": {
          "type": "Text",
          "data": {
            "style": {
              "fontSize": 12.0,
              "color": "#DCDCDC",
            }
          }
        },
        "text_3": {
          "type": "Text",
          "data": {
            "textAlign": "end",
          }
        },
      },
    );
    await DuitRegistry.initialize(
      theme: proc,
    );
  });
  group(
    "Theme tests",
    () {
      test(
        "must apply provided theme for this widget type",
        () {
          final res = ViewAttribute.from(
            "Text",
            {
              "data": "Hi!",
              "theme": "text_1",
            },
            "id",
            tag: null,
          );

          expect(res, isNotNull);
          expect(res.payload.containsKey("style"), isTrue);
        },
      );

      test(
        "not must override original values",
        () {
          final res = ViewAttribute.from(
            "Text",
            {
              "data": "Hi!",
              "theme": "text_1",
              "overrideRule": "themeOverlay",
              "textAlign": "start",
            },
            "id",
            tag: null,
          );

          expect(res, isNotNull);
          expect(res.payload.containsKey("style"), isTrue);
          expect(res.payload["textAlign"], equals("start"));
        },
      );

      test(
        "must override original values",
        () {
          final res = ViewAttribute.from(
            "Text",
            {
              "data": "Hi!",
              "theme": "text_1",
              "overrideRule": "themePriority",
              "textAlign": "start",
            },
            "id",
            tag: null,
          );

          expect(res, isNotNull);
          expect(res.payload.containsKey("style"), isTrue);
          expect(res.payload["textAlign"], equals("center"));
        },
      );
    },
  );

  group(
    "Theme preprocessor tests",
    () {
      test(
        "must throw error for invalid theme",
        () async {
          const preprocessor = DuitThemePreprocessor();

          expect(
            () => preprocessor.tokenize(
              const {
                "text_1": {
                  "type": "Text",
                  "data": {
                    "data": "Hi!",
                  }
                }
              },
            ),
            throwsA(
              isA<FormatException>(),
            ),
          );
        },
      );

      test(
        "must use custom tokenizer",
        () async {
          final preprocessor = DuitThemePreprocessor(
            customWidgetTokenizer: (type, themeData) {
              switch (type) {
                case "SomeCustomWidget":
                  return _SomeWidgetThemeToken(
                    themeData,
                  );
              }

              return null;
            },
          );

          var res = preprocessor.tokenize(
            const {
              "custom_1": {
                "type": "SomeCustomWidget",
                "data": {
                  "data": "Hi!",
                }
              }
            },
          );

          expect(
            res.getToken("custom_1", "SomeCustomWidget"),
            isNotNull,
          );

          res = preprocessor.tokenize(
            const {
              "custom_1": {
                "type": "Custom",
                "data": {
                  "data": "Hi!",
                }
              }
            },
          );

          expect(
            res.getToken("custom_1", "SomeCustomWidget"),
            isA<UnknownThemeToken>(),
          );
        },
      );

      test(
        "must use override tokenizer",
        () async {
          final preprocessor = DuitThemePreprocessor(
            overrideWidgetTokenizer: (type, themeData) {
              switch (type) {
                case "Text":
                  return _OverridedTextThemeToken(
                    themeData,
                  );
              }

              return null;
            },
          );

          expect(
            () => preprocessor.tokenize(
              const {
                "text_1": {
                  "type": "Text",
                  "data": {
                    "style": {
                      "color": "#DCDCDC",
                    },
                  }
                }
              },
            ),
            throwsA(
              isA<FormatException>(),
            ),
          );

          var res = preprocessor.tokenize(
            const {
              "text_3": {
                "type": "Text",
                "data": {
                  "textAlign": "end",
                }
              }
            },
          );

          expect(
            res.getToken("text_3", "Text"),
            isA<_OverridedTextThemeToken>(),
          );
        },
      );

      test(
        "must use defautl tokenizer",
        () {
          final preprocessor = DuitThemePreprocessor(
            overrideWidgetTokenizer: (type, themeData) {
              return null;
            },
          );

          final res = preprocessor.tokenize(
            const {
              "text_1": {
                "type": "Text",
                "data": {
                  "v": "1",
                },
              },
            },
          );

          expect(
            res.getToken("text_1", "Text"),
            isA<TextThemeToken>(),
          );
        },
      );
    },
  );
}
