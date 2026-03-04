import 'package:flutter_duit/flutter_duit.dart';

//Create override token for text widget theme
final class OverrideTextThemeToken extends ThemeToken {
  OverrideTextThemeToken(Map<String, dynamic> data)
      : super(
          const {}, //allow override all fields
          data,
          "Text",
        );
}
