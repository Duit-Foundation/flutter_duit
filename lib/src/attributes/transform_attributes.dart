import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

base class TransformAttributes extends AnimatedPropertyOwner {
  Offset? origin;
  AlignmentGeometry? alignment;
  bool transformHitTests;
  FilterQuality? filterQuality;
  String type;

  TransformAttributes({
    required this.type,
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory TransformAttributes.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final data = json['data'];

    switch (type) {
      case 'translate':
        return TranslateTransform.fromJson(data);
      case 'scale':
        return ScaleTransform.fromJson(data);
      case 'rotate':
        return RotateTransform.fromJson(data);
      case 'flip':
        return FlipTransform.fromJson(data);
      default:
        return TransformAttributes(
            type: 'none', parentBuilderId: '', affectedProperties: null);
    }
  }
}

final class ScaleTransform extends TransformAttributes
    implements DuitAttributes<ScaleTransform> {
  double? scale, scaleX, scaleY;

  ScaleTransform({
    this.scale,
    this.scaleX,
    this.scaleY,
    super.origin,
    super.alignment,
    super.transformHitTests,
    super.filterQuality,
    super.type = 'scale',
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory ScaleTransform.fromJson(Map<String, dynamic> json) {
    return ScaleTransform(
        scale: NumUtils.toDouble(json['scale']),
        scaleX: NumUtils.toDouble(json['scaleX']),
        scaleY: NumUtils.toDouble(json['scaleY']),
        origin: AttributeValueMapper.toOffset(json['origin']),
        alignment: AttributeValueMapper.toAlignment(json['alignment']),
        transformHitTests: json['transformHitTests'] ?? true,
        filterQuality:
            AttributeValueMapper.toFilterQuality(json['filterQuality']),
        parentBuilderId: json['parentBuilderId'],
        affectedProperties: Set.from(
          json['affectedProperties'] ?? {},
        ));
  }

  @override
  ScaleTransform copyWith(other) {
    return ScaleTransform(
      scale: other.scale ?? scale,
      scaleX: other.scaleX ?? scaleX,
      scaleY: other.scaleY ?? scaleY,
      origin: other.origin ?? origin,
      alignment: other.alignment ?? alignment,
      transformHitTests: other.transformHitTests,
      filterQuality: other.filterQuality ?? filterQuality,
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
    return switch (methodName) {
      "fromJson" =>
        RotateTransform.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class TranslateTransform extends TransformAttributes
    implements DuitAttributes<TranslateTransform> {
  Offset? offset;

  TranslateTransform({
    this.offset,
    super.origin,
    super.alignment,
    super.transformHitTests,
    super.filterQuality,
    super.type = 'translate',
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory TranslateTransform.fromJson(Map<String, dynamic> map) {
    return TranslateTransform(
      offset: AttributeValueMapper.toOffset(map['offset']),
      origin: AttributeValueMapper.toOffset(map['origin']),
      alignment: AttributeValueMapper.toAlignment(map['alignment']),
      transformHitTests: map['transformHitTests'] ?? true,
      filterQuality: AttributeValueMapper.toFilterQuality(map['filterQuality']),
      parentBuilderId: map['parentBuilderId'],
      affectedProperties: Set.from(
        map['affectedProperties'] ?? {},
      ),
    );
  }

  @override
  TranslateTransform copyWith(other) {
    return TranslateTransform(
      offset: other.offset ?? offset,
      origin: other.origin ?? origin,
      alignment: other.alignment ?? alignment,
      transformHitTests: other.transformHitTests,
      filterQuality: other.filterQuality ?? filterQuality,
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
    return switch (methodName) {
      "fromJson" =>
        TranslateTransform.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class RotateTransform extends TransformAttributes
    implements DuitAttributes<RotateTransform> {
  double? angle;

  RotateTransform({
    this.angle,
    super.origin,
    super.alignment,
    super.transformHitTests,
    super.filterQuality,
    super.type = 'rotate',
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  @override
  RotateTransform copyWith(other) {
    return RotateTransform(
      angle: other.angle ?? angle,
      origin: other.origin ?? origin,
      alignment: other.alignment ?? alignment,
      transformHitTests: other.transformHitTests,
      filterQuality: other.filterQuality ?? filterQuality,
      parentBuilderId: other.parentBuilderId ?? parentBuilderId,
      affectedProperties: other.affectedProperties ?? affectedProperties,
    );
  }

  factory RotateTransform.fromJson(Map<String, dynamic> map) {
    return RotateTransform(
      angle: NumUtils.toDouble(map['angle']),
      origin: AttributeValueMapper.toOffset(map['origin']),
      alignment: AttributeValueMapper.toAlignment(map['alignment']),
      transformHitTests: map['transformHitTests'] ?? true,
      filterQuality: AttributeValueMapper.toFilterQuality(map['filterQuality']),
      parentBuilderId: map['parentBuilderId'],
      affectedProperties: Set.from(
        map['affectedProperties'] ?? {},
      ),
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
        RotateTransform.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}

final class FlipTransform extends TransformAttributes
    implements DuitAttributes<FlipTransform> {
  bool? flipX, flipY;

  FlipTransform({
    this.flipX,
    this.flipY,
    super.origin,
    super.alignment,
    super.transformHitTests,
    super.filterQuality,
    super.type = 'flip',
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory FlipTransform.fromJson(Map<String, dynamic> json) {
    return FlipTransform(
      flipX: json['flipX'] ?? false,
      flipY: json['flipY'] ?? false,
      origin: AttributeValueMapper.toOffset(json['origin']),
      alignment: AttributeValueMapper.toAlignment(json['alignment']),
      transformHitTests: json['transformHitTests'] ?? true,
      filterQuality: AttributeValueMapper.toFilterQuality(json['filterQuality']),
      parentBuilderId: json['parentBuilderId'],
      affectedProperties: Set.from(
        json['affectedProperties'] ?? {},
      ),
    );
  }

  @override
  FlipTransform copyWith(other) {
    return FlipTransform(
      flipX: flipX ?? flipX,
      flipY: flipY ?? flipY,
      origin: other.origin ?? origin,
      alignment: other.alignment ?? alignment,
      transformHitTests: other.transformHitTests,
      filterQuality: other.filterQuality ?? filterQuality,
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
    return switch (methodName) {
      "fromJson" => FlipTransform.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
