import 'package:flutter_duit/flutter_duit.dart';

extension NonNullValuesExtension on DuitAttributes {
  T assignIfNotNull<T>(
    dynamic value,
    T self,
  ) {
    if (value == null) {
      return self;
    }
    return value as T;
  }
}
