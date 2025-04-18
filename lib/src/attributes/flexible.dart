import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
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
          AttributeValueMapper.toMainAxisAlignment(json["mainAxisAlignment"]),
      textDirection:
          AttributeValueMapper.toTextDirection(json["textDirection"]),
      crossAxisAlignment:
          AttributeValueMapper.toCrossAxisAlignment(json["crossAxisAlignment"]),
      clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
      mainAxisSize: AttributeValueMapper.toMainAxisSize(json["mainAxisSize"]),
      verticalDirection:
          AttributeValueMapper.toVerticalDirection(json["verticalDirection"]),
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

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" => RowAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
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
          AttributeValueMapper.toMainAxisAlignment(json["mainAxisAlignment"]),
      textDirection:
          AttributeValueMapper.toTextDirection(json["textDirection"]),
      crossAxisAlignment:
          AttributeValueMapper.toCrossAxisAlignment(json["crossAxisAlignment"]),
      clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
      mainAxisSize: AttributeValueMapper.toMainAxisSize(json["mainAxisSize"]),
      verticalDirection:
          AttributeValueMapper.toVerticalDirection(json["verticalDirection"]),
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

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        ColumnAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
