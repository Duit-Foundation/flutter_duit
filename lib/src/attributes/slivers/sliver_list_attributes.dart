import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverListAttributes
    implements DuitAttributes<SliverListAttributes>, DynamicChildHolder {
  final bool addAutomaticKeepAlives, addRepaintBoundaries, addSemanticIndexes;

  /// 0 - SliverList.list,
  ///
  /// 1 - SliverList.builder,
  ///
  /// 2 - SliverList.separated
  final int type;
  final Map<String, dynamic>? separator;
  @override
  final List<Map<String, dynamic>>? childObjects;
  @override
  final ArrayMergeStrategy? mergeStrategy;
  @override
  final double? scrollEndReachedThreshold;

  SliverListAttributes({
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
  })  : separator = null,
        childObjects = null,
        mergeStrategy = ArrayMergeStrategy.addToEnd,
        scrollEndReachedThreshold = null,
        type = 0;

  SliverListAttributes.builder({
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.childObjects,
    this.mergeStrategy = ArrayMergeStrategy.addToEnd,
    this.scrollEndReachedThreshold = 150,
  })  : separator = null,
        type = 1;

  SliverListAttributes.separated({
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.separator,
    required this.childObjects,
    this.mergeStrategy = ArrayMergeStrategy.addToEnd,
    this.scrollEndReachedThreshold = 150,
  }) : type = 2;

  factory SliverListAttributes.fromJson(Map<String, dynamic> json) {
    final type = json["type"] as int;

    switch (type) {
      case 1:
        final children = List<JSONObject>.from(json["childObjects"] ?? []);

        return SliverListAttributes.builder(
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          childObjects: children,
          mergeStrategy: ArrayMergeStrategy.fromValue(json["mergeStrategy"]),
          scrollEndReachedThreshold: NumUtils.toDouble(
            json["scrollEndReachedThreshold"],
          ),
        );
      case 2:
        final separator = json["separator"];
        assert(separator != null, "separator must be a Map and non-null value");
        final children = List<JSONObject>.from(json["childObjects"] ?? []);

        return SliverListAttributes.separated(
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          separator: separator,
          childObjects: children,
          mergeStrategy: ArrayMergeStrategy.fromValue(json["mergeStrategy"]),
          scrollEndReachedThreshold: NumUtils.toDouble(
            json["scrollEndReachedThreshold"],
          ),
        );
      default:
        return SliverListAttributes(
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
        );
    }
  }

  @override
  SliverListAttributes copyWith(SliverListAttributes other) {
    switch (type) {
      case 1:
        return SliverListAttributes.builder(
          addAutomaticKeepAlives: other.addAutomaticKeepAlives,
          addRepaintBoundaries: other.addRepaintBoundaries,
          addSemanticIndexes: other.addSemanticIndexes,
          childObjects: other.childObjects ?? childObjects,
          mergeStrategy: other.mergeStrategy ?? mergeStrategy,
          scrollEndReachedThreshold:
              other.scrollEndReachedThreshold ?? scrollEndReachedThreshold,
        );
      case 2:
        return SliverListAttributes.separated(
          addAutomaticKeepAlives: other.addAutomaticKeepAlives,
          addRepaintBoundaries: other.addRepaintBoundaries,
          addSemanticIndexes: other.addSemanticIndexes,
          separator: other.separator ?? separator,
          childObjects: other.childObjects ?? childObjects,
          mergeStrategy: other.mergeStrategy ?? mergeStrategy,
          scrollEndReachedThreshold:
              other.scrollEndReachedThreshold ?? scrollEndReachedThreshold,
        );
      default:
        return SliverListAttributes(
          addAutomaticKeepAlives: other.addAutomaticKeepAlives,
          addRepaintBoundaries: other.addRepaintBoundaries,
          addSemanticIndexes: other.addSemanticIndexes,
        );
    }
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError("$methodName is not implemented");
}
