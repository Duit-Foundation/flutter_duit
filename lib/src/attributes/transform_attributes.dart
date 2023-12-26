import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

base class TransformAttributes {
  Offset? origin;
  AlignmentGeometry? alignment;
  bool transformHitTests;
  FilterQuality? filterQuality;

  TransformAttributes({
    this.origin,
    this.alignment,
    this.transformHitTests = true,
    this.filterQuality,
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
        return TransformAttributes();
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
  });

  factory ScaleTransform.fromJson(Map<String, dynamic> json) {
    return ScaleTransform(
      scale: NumUtils.toDouble(json['scale']),
      scaleX: NumUtils.toDouble(json['scaleX']),
      scaleY: NumUtils.toDouble(json['scaleY']),
      origin: ParamsMapper.convertToOffset(json['origin']),
      alignment: ParamsMapper.convertToAlignment(json['alignment']),
      transformHitTests: json['transformHitTests'],
      filterQuality: ParamsMapper.convertToFilterQuality(json['filterQuality']),
    );
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
    );
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
  });

  factory TranslateTransform.fromJson(Map<String, dynamic> map) {
    return TranslateTransform(
      offset: ParamsMapper.convertToOffset(map['offset']),
      origin: ParamsMapper.convertToOffset(map['origin']),
      alignment: ParamsMapper.convertToAlignment(map['alignment']),
      transformHitTests: map['transformHitTests'],
      filterQuality: ParamsMapper.convertToFilterQuality(map['filterQuality']),
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
    );
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
  });

  @override
  RotateTransform copyWith(other) {
    return RotateTransform(
      angle: other.angle ?? angle,
      origin: other.origin ?? origin,
      alignment: other.alignment ?? alignment,
      transformHitTests: other.transformHitTests,
      filterQuality: other.filterQuality ?? filterQuality,
    );
  }

  factory RotateTransform.fromJson(Map<String, dynamic> map) {
    return RotateTransform(
      angle: NumUtils.toDouble(map['angle']),
      origin: ParamsMapper.convertToOffset(map['origin']),
      alignment: ParamsMapper.convertToAlignment(map['alignment']),
      transformHitTests: map['transformHitTests'],
      filterQuality: ParamsMapper.convertToFilterQuality(map['filterQuality']),
    );
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
  });

  factory FlipTransform.fromJson(Map<String, dynamic> json) {
    return FlipTransform(
      flipX: json['flipX'],
      flipY: json['flipY'],
      origin: ParamsMapper.convertToOffset(json['origin']),
      alignment: ParamsMapper.convertToAlignment(json['alignment']),
      transformHitTests: json['transformHitTests'],
      filterQuality: ParamsMapper.convertToFilterQuality(json['filterQuality']),
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
    );
  }
}
