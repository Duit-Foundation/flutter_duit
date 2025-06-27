import 'dart:ui';

import 'package:flutter_duit/flutter_duit.dart';

final class BackdropFilterAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<BackdropFilterAttributes> {
  final BlendMode blendMode;
  final ImageFilter filter;

  const BackdropFilterAttributes({
    required this.blendMode,
    required this.filter,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory BackdropFilterAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);

    return BackdropFilterAttributes(
      blendMode: AttributeValueMapper.toBlendMode(view["blendMode"]),
      filter: AttributeValueMapper.toImageFilter(view["filter"]),
      affectedProperties: view.affectedProperties,
      parentBuilderId: view.parentBuilderId,
    );
  }

  @override
  BackdropFilterAttributes copyWith(BackdropFilterAttributes other) {
    return BackdropFilterAttributes(
      blendMode: other.blendMode,
      filter: other.filter,
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    throw UnimplementedError();
  }
}
