import 'package:flutter_duit/flutter_duit.dart';

abstract interface class DynamicChildHolder {
  final List<Map<String, dynamic>>? childObjects;
  final ArrayMergeStrategy? mergeStrategy;
  final double? scrollEndReachedThreshold;

  const DynamicChildHolder({
    this.childObjects,
    this.mergeStrategy,
    this.scrollEndReachedThreshold,
  });
}
