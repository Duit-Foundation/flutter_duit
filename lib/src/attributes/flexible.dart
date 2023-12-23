import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Flexible widgets.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
sealed class FlexAttributes {
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final Clip? clipBehavior;

  FlexAttributes({
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.textDirection,
    this.clipBehavior,
    this.crossAxisAlignment,
    this.verticalDirection,
  });
}

final class RowAttributes extends FlexAttributes
    implements DuitAttributes<RowAttributes> {
  RowAttributes({
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textDirection,
    super.clipBehavior,
    super.crossAxisAlignment,
    super.verticalDirection,
  });

  factory RowAttributes.fromJson(JSONObject json) {
    return RowAttributes(
      mainAxisAlignment:
          ParamsMapper.convertToMainAxisAlignment(json["mainAxisAlignment"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
      crossAxisAlignment:
          ParamsMapper.convertToCrossAxisAlignment(json["crossAxisAlignment"]),
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
      mainAxisSize: ParamsMapper.convertToMainAxisSize(json["mainAxisSize"]),
      verticalDirection:
          ParamsMapper.convertToVerticalDirection(json["verticalDirection"]),
    );
  }

  @override
  RowAttributes copyWith(RowAttributes other) {
    return RowAttributes(
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      mainAxisSize: other.mainAxisSize ?? mainAxisSize,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      textDirection: other.textDirection ?? textDirection,
      verticalDirection: other.verticalDirection ?? verticalDirection,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}

final class ColumnAttributes extends FlexAttributes
    implements DuitAttributes<ColumnAttributes> {
  ColumnAttributes({
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textDirection,
    super.clipBehavior,
    super.crossAxisAlignment,
    super.verticalDirection,
  });

  factory ColumnAttributes.fromJson(JSONObject json) {
    return ColumnAttributes(
      mainAxisAlignment:
          ParamsMapper.convertToMainAxisAlignment(json["mainAxisAlignment"]),
      textDirection: ParamsMapper.convertToTextDirection(json["textDirection"]),
      crossAxisAlignment:
          ParamsMapper.convertToCrossAxisAlignment(json["crossAxisAlignment"]),
      clipBehavior: ParamsMapper.convertToClip(json["clipBehavior"]),
      mainAxisSize: ParamsMapper.convertToMainAxisSize(json["mainAxisSize"]),
      verticalDirection:
          ParamsMapper.convertToVerticalDirection(json["verticalDirection"]),
    );
  }

  @override
  ColumnAttributes copyWith(ColumnAttributes other) {
    return ColumnAttributes(
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      mainAxisSize: other.mainAxisSize ?? mainAxisSize,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      textDirection: other.textDirection ?? textDirection,
      verticalDirection: other.verticalDirection ?? verticalDirection,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }
}
