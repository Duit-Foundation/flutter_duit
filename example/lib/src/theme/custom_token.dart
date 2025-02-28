import 'package:flutter_duit/flutter_duit.dart';

//Create override token for text widget theme
final class CustomWidgetThemeToken extends ThemeToken {
  CustomWidgetThemeToken(Map<String, dynamic> data)
      : super(
          const {}, //allow override all fields
          data,
          "ExampleCustomWidget",
        );
}
