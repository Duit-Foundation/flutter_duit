import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SliverGridAttributes
    implements DuitAttributes<SliverGridAttributes>, DynamicChildHolder {
  final bool addAutomaticKeepAlives, addRepaintBoundaries, addSemanticIndexes;
  final int crossAxisCount;
  final double mainAxisSpacing,
      crossAxisSpacing,
      childAspectRatio,
      maxCrossAxisExtent;

  //Duit specific properties
  final GridConstructor constructor;
  final String sliverGridDelegateKey, sliverChildDelegateKey;
  final Map<String, dynamic> sliverGridDelegateOptions;

  //GridView.builder custom props
  @override
  final List<Map<String, dynamic>>? childObjects;
  @override
  final ArrayMergeStrategy? mergeStrategy;
  @override
  final double? scrollEndReachedThreshold;

  const SliverGridAttributes.common({
    required this.sliverGridDelegateKey,
    required this.sliverGridDelegateOptions,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
  })  : constructor = GridConstructor.common,
        crossAxisCount = 0,
        childAspectRatio = 0.0,
        crossAxisSpacing = 0.0,
        mainAxisSpacing = 0.0,
        maxCrossAxisExtent = 0.0,
        sliverChildDelegateKey = "",
        childObjects = null,
        mergeStrategy = null,
        scrollEndReachedThreshold = null;

  const SliverGridAttributes.count({
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.childAspectRatio,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
  })  : constructor = GridConstructor.count,
        maxCrossAxisExtent = 0.0,
        sliverGridDelegateKey = "",
        sliverChildDelegateKey = "",
        childObjects = null,
        mergeStrategy = null,
        sliverGridDelegateOptions = const {},
        scrollEndReachedThreshold = null;

  const SliverGridAttributes.builder({
    required this.sliverGridDelegateKey,
    required this.childObjects,
    required this.mergeStrategy,
    required this.scrollEndReachedThreshold,
    required this.sliverGridDelegateOptions,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
  })  : constructor = GridConstructor.builder,
        crossAxisCount = 0,
        childAspectRatio = 0.0,
        crossAxisSpacing = 0.0,
        mainAxisSpacing = 0.0,
        maxCrossAxisExtent = 0.0,
        sliverChildDelegateKey = "";

  const SliverGridAttributes.extent({
    required this.maxCrossAxisExtent,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.childAspectRatio,
    required this.addAutomaticKeepAlives,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  })  : constructor = GridConstructor.extent,
        crossAxisCount = 0,
        sliverGridDelegateKey = "",
        sliverChildDelegateKey = "",
        childObjects = null,
        mergeStrategy = null,
        sliverGridDelegateOptions = const {},
        scrollEndReachedThreshold = null;

  factory SliverGridAttributes.fromJson(Map<String, dynamic> json) {
    final gridType = GridConstructor.fromValue(json["constructor"]);

    switch (gridType) {
      case GridConstructor.common:
        final gridDelegateKey = json["sliverGridDelegateKey"];
        assert(gridDelegateKey != null && gridDelegateKey.isNotEmpty,
            "sliverGridDelegateKey property cannot be null or empty");
        return SliverGridAttributes.common(
          sliverGridDelegateKey: gridDelegateKey,
          sliverGridDelegateOptions:
              json["sliverGridDelegateOptions"] ?? const {},
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          // childAspectRatio: NumUtils.toDoubleWithNullReplacement(
          //   json["childAspectRatio"],
          //   1.0,
          // ),
          // crossAxisSpacing: NumUtils.toDoubleWithNullReplacement(
          //   json["crossAxisSpacing"],
          //   0.0,
          // ),
          // mainAxisSpacing: NumUtils.toDoubleWithNullReplacement(
          //   json["mainAxisSpacing"],
          //   0.0,
          // ),
        );
      case GridConstructor.count:
        final crossAxisCount = json["crossAxisCount"];
        assert(crossAxisCount is int && crossAxisCount > 0,
            "crossAxisCount property cannot be non-integer value or less than 1");
        return SliverGridAttributes.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["crossAxisSpacing"],
            0.0,
          ),
          mainAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["mainAxisSpacing"],
            0.0,
          ),
          childAspectRatio: NumUtils.toDoubleWithNullReplacement(
            json["childAspectRatio"],
            1.0,
          ),
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
        );
      case GridConstructor.extent:
        final maxCrossAxisExtent = json["maxCrossAxisExtent"];
        assert(maxCrossAxisExtent != null,
            "maxCrossAxisExtent property cannot be null");
        return SliverGridAttributes.extent(
          maxCrossAxisExtent: NumUtils.toDoubleWithNullReplacement(
            maxCrossAxisExtent,
          ),
          crossAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["crossAxisSpacing"],
            0.0,
          ),
          mainAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["mainAxisSpacing"],
            0.0,
          ),
          childAspectRatio: NumUtils.toDoubleWithNullReplacement(
            json["childAspectRatio"],
            1.0,
          ),
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
        );
      case GridConstructor.builder:
        final gridDelegateKey = json["sliverGridDelegateKey"];
        assert(gridDelegateKey != null && gridDelegateKey.isNotEmpty,
            "sliverGridDelegateKey property cannot be null or empty");

        final children =
            List<Map<String, dynamic>>.from(json["childObjects"] ?? []);

        return SliverGridAttributes.builder(
          sliverGridDelegateKey: gridDelegateKey,
          sliverGridDelegateOptions:
              json["sliverGridDelegateOptions"] ?? const {},
          childObjects: children,
          scrollEndReachedThreshold: json["scrollEndReachedThreshold"],
          mergeStrategy: ArrayMergeStrategy.fromValue(json["mergeStrategy"]),
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
        );
    }

    throw UnimplementedError();
  }

  @override
  SliverGridAttributes copyWith(SliverGridAttributes other) {
    final gridType = constructor;

    switch (gridType) {
      case GridConstructor.count:
        return SliverGridAttributes.count(
          crossAxisCount: assignIfNotNull(
            crossAxisCount,
            other.crossAxisCount,
          ),
          crossAxisSpacing: assignIfNotNull(
            crossAxisSpacing,
            other.crossAxisSpacing,
          ),
          mainAxisSpacing: assignIfNotNull(
            mainAxisSpacing,
            other.mainAxisSpacing,
          ),
          childAspectRatio: assignIfNotNull(
            childAspectRatio,
            other.childAspectRatio,
          ),
          addAutomaticKeepAlives: assignIfNotNull(
            addAutomaticKeepAlives,
            other.addAutomaticKeepAlives,
          ),
          addRepaintBoundaries: assignIfNotNull(
            addRepaintBoundaries,
            other.addRepaintBoundaries,
          ),
          addSemanticIndexes: assignIfNotNull(
            addSemanticIndexes,
            other.addSemanticIndexes,
          ),
        );
      case GridConstructor.extent:
        return SliverGridAttributes.extent(
          maxCrossAxisExtent: maxCrossAxisExtent, //copy prohibited
          crossAxisSpacing: assignIfNotNull(
            crossAxisSpacing,
            other.crossAxisSpacing,
          ),
          mainAxisSpacing: assignIfNotNull(
            mainAxisSpacing,
            other.mainAxisSpacing,
          ),
          childAspectRatio: assignIfNotNull(
            childAspectRatio,
            other.childAspectRatio,
          ),
          addAutomaticKeepAlives: assignIfNotNull(
            addAutomaticKeepAlives,
            other.addAutomaticKeepAlives,
          ),
          addRepaintBoundaries: assignIfNotNull(
            addRepaintBoundaries,
            other.addRepaintBoundaries,
          ),
          addSemanticIndexes: assignIfNotNull(
            addSemanticIndexes,
            other.addSemanticIndexes,
          ),
        );
      case GridConstructor.builder:
        var children = childObjects ?? const [];

        switch (mergeStrategy!) {
          case ArrayMergeStrategy.addToEnd:
            children.addAll(other.childObjects!);
            break;
          case ArrayMergeStrategy.addToStart:
            children.insertAll(0, other.childObjects!);
            break;
          case ArrayMergeStrategy.replace:
            children = other.childObjects ?? const [];
            break;
        }
        return SliverGridAttributes.builder(
          sliverGridDelegateKey: sliverGridDelegateKey, //copy prohibited
          childObjects: children,
          sliverGridDelegateOptions:
              sliverGridDelegateOptions, //copy prohibited
          scrollEndReachedThreshold: assignIfNotNull(
            scrollEndReachedThreshold,
            other.scrollEndReachedThreshold,
          ),
          mergeStrategy: mergeStrategy, //copy prohibited

          addAutomaticKeepAlives: assignIfNotNull(
            addAutomaticKeepAlives,
            other.addAutomaticKeepAlives,
          ),
          addRepaintBoundaries: assignIfNotNull(
            addRepaintBoundaries,
            other.addRepaintBoundaries,
          ),
          addSemanticIndexes: assignIfNotNull(
            addSemanticIndexes,
            other.addSemanticIndexes,
          ),
        );
      case GridConstructor.common:
        return SliverGridAttributes.common(
          addAutomaticKeepAlives: assignIfNotNull(
            addAutomaticKeepAlives,
            other.addAutomaticKeepAlives,
          ),
          addRepaintBoundaries: assignIfNotNull(
            addRepaintBoundaries,
            other.addRepaintBoundaries,
          ),
          addSemanticIndexes: assignIfNotNull(
            addSemanticIndexes,
            other.addSemanticIndexes,
          ),
          sliverGridDelegateKey: sliverGridDelegateKey, //copy prohibited
          sliverGridDelegateOptions:
              sliverGridDelegateOptions, //copy prohibited
        );
    }
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError();
}
