import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/rendering.dart';

final class OverflowBoxAttributes
    implements DuitAttributes<OverflowBoxAttributes> {
  final double? minWidth, maxWidth, minHeight, maxHeight;
  final AlignmentGeometry? alignment;
  final OverflowBoxFit? fit;

  const OverflowBoxAttributes({
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.fit,
    this.alignment,
  });

  @override
  OverflowBoxAttributes copyWith(OverflowBoxAttributes other) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
