import 'package:flutter_duit/src/ui/element_type.dart';
import 'package:flutter_duit/src/ui/theme/preprocessor.dart';
import 'package:flutter_duit/src/ui/theme/tokens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:duit_kernel/duit_kernel.dart';

void main() {
  group('Theme token instance creation tests', () {
    late DuitThemePreprocessor preprocessor;

    setUp(() {
      preprocessor = const DuitThemePreprocessor();
    });

    group('AttendedWidgetThemeToken', () {
      test('should create token for checkbox with valid data', () {
        final token = preprocessor.createToken(
          ElementType.checkbox.name,
          {
            'activeColor': '#FF0000',
            'checkColor': '#FFFFFF',
            'visualDensity': 'standard',
          },
        );

        expect(token, isA<AttendedWidgetThemeToken>());
        expect(token.type, equals(ElementType.checkbox.name));
        expect(token.widgetTheme['activeColor'], equals('#FF0000'));
        expect(token.widgetTheme['checkColor'], equals('#FFFFFF'));
      });

      test('should create token for switchW with valid data', () {
        final token = preprocessor.createToken(
          ElementType.switch_.name,
          {
            'activeColor': '#00FF00',
            'inactiveThumbColor': '#CCCCCC',
          },
        );

        expect(token, isA<AttendedWidgetThemeToken>());
        expect(token.type, equals(ElementType.switch_.name));
        expect(token.widgetTheme['activeColor'], equals('#00FF00'));
      });

      test('should create token for textField with valid data', () {
        final token = preprocessor.createToken(
          ElementType.textField.name,
          {
            'hintText': 'Enter text',
            'borderRadius': 8.0,
          },
        );

        expect(token, isA<AttendedWidgetThemeToken>());
        expect(token.type, equals(ElementType.textField.name));
        expect(token.widgetTheme['hintText'], equals('Enter text'));
      });

      test('should throw exception when excluded field "value" is present', () {
        expect(
          () => preprocessor.tokenize({
            'attended_test': {
              'type': ElementType.checkbox.name,
              'data': {
                'activeColor': '#FF0000',
                'value': true, // исключенное поле
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('RadioGroupContextThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.radioGroupContext.name,
          {
            'spacing': 8.0,
            'direction': 'vertical',
          },
        );

        expect(token, isA<RadioGroupContextThemeToken>());
        expect(token.type, equals(ElementType.radioGroupContext.name));
        expect(token.widgetTheme['spacing'], equals(8.0));
      });

      test('should throw exception when excluded field "groupValue" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'radio_group_test': {
              'type': ElementType.radioGroupContext.name,
              'data': {
                'spacing': 8.0,
                'groupValue': 'test_value',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('RadioThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.radio.name,
          {
            'activeColor': '#FF5722',
            'focusColor': '#FFCCBC',
          },
        );

        expect(token, isA<RadioThemeToken>());
        expect(token.type, equals(ElementType.radio.name));
        expect(token.widgetTheme['activeColor'], equals('#FF5722'));
      });

      test(
          'should throw exception when excluded field "parentBuilderId" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'radio_test': {
              'type': ElementType.radio.name,
              'data': {
                'activeColor': '#FF5722',
                'parentBuilderId': 'test_id',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('TextThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.text.name,
          {
            'textAlign': 'center',
            'style': {
              'fontSize': 16.0,
              'color': '#333333',
            },
          },
        );

        expect(token, isA<TextThemeToken>());
        expect(token.type, equals(ElementType.text.name));
        expect(token.widgetTheme['textAlign'], equals('center'));
      });

      test('should throw exception when excluded field "data" is present', () {
        expect(
          () => preprocessor.tokenize({
            'text_test': {
              'type': ElementType.text.name,
              'data': {
                'textAlign': 'center',
                'data': 'Hello World',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('AnimatedPropOwnerThemeToken', () {
      test('should create token for align with valid data', () {
        final token = preprocessor.createToken(
          ElementType.align.name,
          {
            'alignment': 'center',
            'widthFactor': 1.0,
          },
        );

        expect(token, isA<AnimatedPropOwnerThemeToken>());
        expect(token.type, equals(ElementType.align.name));
        expect(token.widgetTheme['alignment'], equals('center'));
      });

      test(
          'should throw exception when excluded field "affectedProperties" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'animated_prop_test': {
              'type': ElementType.container.name,
              'data': {
                'padding': {'all': 16.0},
                'affectedProperties': ['padding'],
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('ImageThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.image.name,
          {
            'width': 200.0,
            'height': 150.0,
            'fit': 'cover',
          },
        );

        expect(token, isA<ImageThemeToken>());
        expect(token.type, equals(ElementType.image.name));
        expect(token.widgetTheme['width'], equals(200.0));
      });

      test('should throw exception when excluded field "src" is present', () {
        expect(
          () => preprocessor.tokenize({
            'image_test': {
              'type': ElementType.image.name,
              'data': {
                'width': 200.0,
                'src': 'https://example.com/image.jpg',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('ImplicitAnimatableThemeToken', () {
      test('should create token for animatedOpacity with valid data', () {
        final token = preprocessor.createToken(
          ElementType.animatedOpacity.name,
          {
            'duration': 500,
            'opacity': 0.7,
          },
        );

        expect(token, isA<ImplicitAnimatableThemeToken>());
        expect(token.type, equals(ElementType.animatedOpacity.name));
        expect(token.widgetTheme['duration'], equals(500));
      });

      test('should throw exception when excluded field "onEnd" is present', () {
        expect(
          () => preprocessor.tokenize({
            'implicit_anim_test': {
              'type': ElementType.animatedOpacity.name,
              'data': {
                'duration': 500,
                'onEnd': 'callback',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('RichTextThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.richText.name,
          {
            'textAlign': 'justify',
            'softWrap': true,
          },
        );

        expect(token, isA<RichTextThemeToken>());
        expect(token.type, equals(ElementType.richText.name));
        expect(token.widgetTheme['textAlign'], equals('justify'));
      });

      test('should throw exception when excluded field "textSpan" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'rich_text_test': {
              'type': ElementType.richText.name,
              'data': {
                'textAlign': 'justify',
                'textSpan': {
                  'text': 'Sample text',
                },
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('SliderThemeToken', () {
      test('should create token with valid data', () {
        final token = preprocessor.createToken(
          ElementType.slider.name,
          {
            'min': 0.0,
            'max': 100.0,
            'divisions': 10,
          },
        );

        expect(token, isA<SliderThemeToken>());
        expect(token.type, equals(ElementType.slider.name));
        expect(token.widgetTheme['min'], equals(0.0));
      });

      test('should throw exception when excluded field "onChanged" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'slider_test': {
              'type': ElementType.slider.name,
              'data': {
                'min': 0.0,
                'onChanged': 'callback',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('ExcludeGestureCallbacksThemeToken', () {
      test('should create token for gestureDetector with valid data', () {
        final token = preprocessor.createToken(
          ElementType.gestureDetector.name,
          {
            'behavior': 'opaque',
            'excludeFromSemantics': false,
          },
        );

        expect(token, isA<ExcludeGestureCallbacksThemeToken>());
        expect(token.type, equals(ElementType.gestureDetector.name));
        expect(token.widgetTheme['behavior'], equals('opaque'));
      });

      test('should throw exception when excluded field "onTap" is present', () {
        expect(
          () => preprocessor.tokenize({
            'gesture_test': {
              'type': ElementType.gestureDetector.name,
              'data': {
                'behavior': 'opaque',
                'onTap': 'callback',
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('ExcludeChildThemeToken', () {
      test('should create token for appBar with valid data', () {
        final token = preprocessor.createToken(
          ElementType.appBar.name,
          {
            'elevation': 4.0,
            'backgroundColor': '#2196F3',
          },
        );

        expect(token, isA<ExcludeChildThemeToken>());
        expect(token.type, equals(ElementType.appBar.name));
        expect(token.widgetTheme['elevation'], equals(4.0));
      });

      test('should throw exception when excluded field "title" is present', () {
        expect(
          () => preprocessor.tokenize({
            'exclude_child_test': {
              'type': ElementType.appBar.name,
              'data': {
                'elevation': 4.0,
                'title': {'type': 'Text'},
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('DynamicChildHolderThemeToken', () {
      test('should create token for gridView with valid data', () {
        final token = preprocessor.createToken(
          ElementType.gridView.name,
          {
            'scrollDirection': 'vertical',
            'reverse': false,
          },
        );

        expect(token, isA<DynamicChildHolderThemeToken>());
        expect(token.type, equals(ElementType.gridView.name));
        expect(token.widgetTheme['scrollDirection'], equals('vertical'));
      });

      test(
          'should throw exception when excluded field "childObjects" is present',
          () {
        expect(
          () => preprocessor.tokenize({
            'dynamic_child_test': {
              'type': ElementType.gridView.name,
              'data': {
                'scrollDirection': 'vertical',
                'childObjects': [
                  {'type': 'Container'}
                ],
              },
            },
          }),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('DefaultThemeToken', () {
      test('should create token for elevatedButton with valid data', () {
        final token = preprocessor.createToken(
          ElementType.elevatedButton.name,
          {
            'style': {
              'backgroundColor': '#4CAF50',
              'foregroundColor': '#FFFFFF',
            },
            'clipBehavior': 'antiAlias',
          },
        );

        expect(token, isA<DefaultThemeToken>());
        expect(token.type, equals(ElementType.elevatedButton.name));
        expect(
            token.widgetTheme['style']['backgroundColor'], equals('#4CAF50'));
      });

      test('should create token for center with valid data', () {
        final token = preprocessor.createToken(
          ElementType.center.name,
          {
            'widthFactor': 2.0,
            'heightFactor': 1.5,
          },
        );

        expect(token, isA<DefaultThemeToken>());
        expect(token.type, equals(ElementType.center.name));
        expect(token.widgetTheme['widthFactor'], equals(2.0));
        expect(token.widgetTheme['heightFactor'], equals(1.5));
      });

      test('should create token for safeArea with valid data', () {
        final token = preprocessor.createToken(
          ElementType.safeArea.name,
          {
            'left': true,
            'top': true,
            'right': true,
            'bottom': false,
            'minimum': {'all': 16.0},
          },
        );

        expect(token, isA<DefaultThemeToken>());
        expect(token.type, equals(ElementType.safeArea.name));
        expect(token.widgetTheme['left'], equals(true));
        expect(token.widgetTheme['bottom'], equals(false));
      });

      test('should create token for repaintBoundary with valid data', () {
        final token = preprocessor.createToken(
          ElementType.repaintBoundary.name,
          {
            'customProperty': 'test_value',
          },
        );

        expect(token, isA<DefaultThemeToken>());
        expect(token.type, equals(ElementType.repaintBoundary.name));
        expect(token.widgetTheme['customProperty'], equals('test_value'));
      });

      test('should create token for ignorePointer with valid data', () {
        final token = preprocessor.createToken(
          ElementType.ignorePointer.name,
          {
            'ignoring': true,
            'ignoringSemantics': false,
          },
        );

        expect(token, isA<DefaultThemeToken>());
        expect(token.type, equals(ElementType.ignorePointer.name));
        expect(token.widgetTheme['ignoring'], equals(true));
        expect(token.widgetTheme['ignoringSemantics'], equals(false));
      });

      test('DefaultThemeToken should not exclude fields (empty excludedFields)',
          () {
        // DefaultThemeToken не имеет исключенных полей, поэтому любые данные должны проходить
        expect(
          () => preprocessor.tokenize({
            'default_test': {
              'type': ElementType.elevatedButton.name,
              'data': {
                'style': {'backgroundColor': '#4CAF50'},
                'parentBuilderId': 'test_id',
                'affectedProperties': ['color'],
                'onTap': 'callback',
                'value': true,
              },
            },
          }),
          returnsNormally,
        );
      });
    });
  });
}
