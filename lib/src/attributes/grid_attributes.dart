import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

enum GridConstructor {
  common,
  count,
  builder,
  extent;
  // custom;

  static fromValue(dynamic value) {
    return switch (value) {
      "common" || 0 => GridConstructor.common,
      "count" || 1 => GridConstructor.count,
      "builder" || 3 => GridConstructor.builder,
      "extent" || 4 => GridConstructor.extent,
      // "custom" || 5 => GridConstructor.custom,
      _ => throw ArgumentError("Invalid GridConstructor value: $value"),
    };
  }
}

final class GridViewAttributes
    implements DuitAttributes<GridViewAttributes>, DynamicChildHolder {
  //Flutter GridView properties
  final double mainAxisSpacing,
      crossAxisSpacing,
      childAspectRatio,
      maxCrossAxisExtent;
  final double? cacheExtent;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final bool? primary;
  final bool reverse,
      shrinkWrap,
      addAutomaticKeepAlives,
      addRepaintBoundaries,
      addSemanticIndexes;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final String? restorationId;
  /*NOTE
  * HitTestBehavior is not supported in the minimum version of Flutter for the flutter_duit package (v3.22.3). 
  * If a decision is made to stop supporting compatibility with this version of the framework, 
  * it will be possible to return support for HitTestBehavior for GridView by removing the comments
  final HitTestBehavior hitTestBehavior;
  */
  //GridView.count
  final int crossAxisCount;

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

  const GridViewAttributes.common({
    required this.sliverGridDelegateKey,
    required this.sliverGridDelegateOptions,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    // this.hitTestBehavior = HitTestBehavior.opaque,
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

  const GridViewAttributes.count({
    required this.crossAxisCount,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.shrinkWrap = false,
    this.padding,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    // this.hitTestBehavior = HitTestBehavior.opaque,
  })  : constructor = GridConstructor.count,
        maxCrossAxisExtent = 0.0,
        sliverGridDelegateKey = "",
        sliverChildDelegateKey = "",
        childObjects = null,
        mergeStrategy = null,
        sliverGridDelegateOptions = const {},
        scrollEndReachedThreshold = null;

  const GridViewAttributes.builder({
    required this.sliverGridDelegateKey,
    required this.childObjects,
    required this.mergeStrategy,
    required this.scrollEndReachedThreshold,
    required this.sliverGridDelegateOptions,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    // this.hitTestBehavior = HitTestBehavior.opaque,
  })  : constructor = GridConstructor.builder,
        crossAxisCount = 0,
        childAspectRatio = 0.0,
        crossAxisSpacing = 0.0,
        mainAxisSpacing = 0.0,
        maxCrossAxisExtent = 0.0,
        sliverChildDelegateKey = "";

  const GridViewAttributes.extent({
    required this.maxCrossAxisExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.shrinkWrap = false,
    this.padding,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    // this.hitTestBehavior = HitTestBehavior.opaque,
  })  : constructor = GridConstructor.extent,
        crossAxisCount = 0,
        sliverGridDelegateKey = "",
        sliverChildDelegateKey = "",
        childObjects = null,
        mergeStrategy = null,
        sliverGridDelegateOptions = const {},
        scrollEndReachedThreshold = null;

  // const GridViewAttributes.custom({
  //   required this.sliverGridDelegateKey,
  //   required this.sliverChildDelegateKey,
  //   this.scrollDirection = Axis.vertical,
  //   this.reverse = false,
  //   this.primary,
  //   this.physics = const AlwaysScrollableScrollPhysics(),
  //   this.shrinkWrap = false,
  //   this.padding,
  //   this.addAutomaticKeepAlives = true,
  //   this.addRepaintBoundaries = true,
  //   this.addSemanticIndexes = true,
  //   this.cacheExtent,
  //   this.semanticChildCount,
  //   this.dragStartBehavior = DragStartBehavior.start,
  //   this.clipBehavior = Clip.hardEdge,
  //   this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  //   this.restorationId,
  //   this.hitTestBehavior = HitTestBehavior.opaque,
  // })  : constructor = GridConstructor.extent,
  //       anchor = 0.0,
  //       crossAxisCount = 0,
  //       childAspectRatio = 0.0,
  //       crossAxisSpacing = 0.0,
  //       mainAxisSpacing = 0.0,
  //       maxCrossAxisExtent = 0.0,
  //       childObjects = null,
  //       scrollBehavior = null;

  factory GridViewAttributes.fromJson(Map<String, dynamic> json) {
    final gridType = GridConstructor.fromValue(json["constructor"]);

    switch (gridType) {
      case GridConstructor.common:
        final gridDelegateKey = json["sliverGridDelegateKey"];
        assert(gridDelegateKey != null && gridDelegateKey.isNotEmpty,
            "sliverGridDelegateKey property cannot be null or empty");
        return GridViewAttributes.common(
          sliverGridDelegateKey: gridDelegateKey,
          scrollDirection: AttributeValueMapper.toAxis(
            json["scrollDirection"],
          ),
          sliverGridDelegateOptions:
              json["sliverGridDelegateOptions"] ?? const {},
          reverse: json["reverse"] ?? false,
          primary: json["primary"],
          physics: AttributeValueMapper.toScrollPhysics(json["physics"]),
          shrinkWrap: json["shrinkWrap"] ?? false,
          padding: AttributeValueMapper.toEdgeInsets(json["padding"]),
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          cacheExtent: json["cacheExtent"],
          semanticChildCount: json["semanticChildCount"],
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
              json["dragStartBehavior"]),
          clipBehavior: AttributeValueMapper.toClipNonNull(
            json["clipBehavior"],
            Clip.hardEdge,
          ),
        );
      case GridConstructor.count:
        final crossAxisCount = json["crossAxisCount"];
        assert(crossAxisCount is int && crossAxisCount > 0,
            "crossAxisCount property cannot be non-integer value or less than 1");
        return GridViewAttributes.count(
          crossAxisCount: crossAxisCount,
          reverse: json["reverse"] ?? false,
          cacheExtent: json["cacheExtent"],
          clipBehavior: AttributeValueMapper.toClipNonNull(
            json["clipBehavior"],
            Clip.hardEdge,
          ),
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
              json["dragStartBehavior"]),
          keyboardDismissBehavior:
              AttributeValueMapper.toKeyboardDismissBehavior(
                  json["keyboardDismissBehavior"]),
          padding: AttributeValueMapper.toEdgeInsets(json["padding"]),
          physics: AttributeValueMapper.toScrollPhysics(json["physics"]),
          primary: json["primary"],
          shrinkWrap: json["shrinkWrap"] ?? false,
          scrollDirection: AttributeValueMapper.toAxis(json["scrollDirection"]),
          semanticChildCount: json["semanticChildCount"],
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          restorationId: json["restorationId"],
          // hitTestBehavior:
          //     AttributeValueMapper.toHitTestBehavior(json["hitTestBehavior"]),
          childAspectRatio: NumUtils.toDoubleWithNullReplacement(
            json["childAspectRatio"],
            1.0,
          ),
          crossAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["crossAxisSpacing"],
            0.0,
          ),
          mainAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["mainAxisSpacing"],
            0.0,
          ),
        );
      case GridConstructor.extent:
        final maxCrossAxisExtent = json["maxCrossAxisExtent"];
        assert(maxCrossAxisExtent != null,
            "maxCrossAxisExtent property cannot be null");
        return GridViewAttributes.extent(
          maxCrossAxisExtent: NumUtils.toDoubleWithNullReplacement(
            maxCrossAxisExtent,
          ),
          reverse: json["reverse"] ?? false,
          cacheExtent: NumUtils.toDouble(json["cacheExtent"]),
          clipBehavior: AttributeValueMapper.toClipNonNull(
            json["clipBehavior"],
            Clip.hardEdge,
          ),
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
            json["dragStartBehavior"],
          ),
          keyboardDismissBehavior:
              AttributeValueMapper.toKeyboardDismissBehavior(
            json["keyboardDismissBehavior"],
          ),
          padding: AttributeValueMapper.toEdgeInsets(
            json["padding"],
          ),
          physics: AttributeValueMapper.toScrollPhysics(
            json["physics"],
          ),
          primary: json["primary"],
          shrinkWrap: json["shrinkWrap"] ?? false,
          scrollDirection: AttributeValueMapper.toAxis(
            json["scrollDirection"],
          ),
          semanticChildCount: json["semanticChildCount"],
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          restorationId: json["restorationId"],
          // hitTestBehavior: AttributeValueMapper.toHitTestBehavior(
          //   json["hitTestBehavior"],
          // ),
          childAspectRatio: NumUtils.toDoubleWithNullReplacement(
            json["childAspectRatio"],
            1.0,
          ),
          crossAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["crossAxisSpacing"],
            0.0,
          ),
          mainAxisSpacing: NumUtils.toDoubleWithNullReplacement(
            json["mainAxisSpacing"],
            0.0,
          ),
        );
      case GridConstructor.builder:
        final gridDelegateKey = json["sliverGridDelegateKey"];
        assert(gridDelegateKey != null && gridDelegateKey.isNotEmpty,
            "sliverGridDelegateKey property cannot be null or empty");

        final children =
            List<Map<String, dynamic>>.from(json["childObjects"] ?? []);

        return GridViewAttributes.builder(
          sliverGridDelegateKey: gridDelegateKey,
          sliverGridDelegateOptions:
              json["sliverGridDelegateOptions"] ?? const {},
          childObjects: children,
          scrollEndReachedThreshold: json["scrollEndReachedThreshold"],
          mergeStrategy: ArrayMergeStrategy.fromValue(json["mergeStrategy"]),
          scrollDirection: AttributeValueMapper.toAxis(json["scrollDirection"]),
          reverse: json["reverse"] ?? false,
          shrinkWrap: json["shrinkWrap"] ?? false,
          addSemanticIndexes: json["addSemanticIndexes"] ?? true,
          addRepaintBoundaries: json["addRepaintBoundaries"] ?? true,
          addAutomaticKeepAlives: json["addAutomaticKeepAlives"] ?? true,
          primary: json["primary"],
          physics: AttributeValueMapper.toScrollPhysics(json["physics"]),
          cacheExtent: json["cacheExtent"],
          semanticChildCount: json["semanticChildCount"],
          dragStartBehavior: AttributeValueMapper.toDragStartBehavior(
              json["dragStartBehavior"]),
          clipBehavior: AttributeValueMapper.toClipNonNull(
            json["clipBehavior"],
            Clip.hardEdge,
          ),
        );
    }

    throw UnimplementedError();
  }

  @override
  GridViewAttributes copyWith(GridViewAttributes other) {
    final gridType = constructor;

    switch (gridType) {
      case GridConstructor.count:
        return GridViewAttributes.count(
          crossAxisCount: assignIfNotNull(
            crossAxisCount,
            other.crossAxisCount,
          ),
          reverse: assignIfNotNull(
            reverse,
            other.reverse,
          ),
          cacheExtent: assignIfNotNull(
            cacheExtent,
            other.cacheExtent,
          ),
          clipBehavior: assignIfNotNull(
            clipBehavior,
            other.clipBehavior,
          ),
          dragStartBehavior: assignIfNotNull(
            dragStartBehavior,
            other.dragStartBehavior,
          ),
          keyboardDismissBehavior: assignIfNotNull(
            keyboardDismissBehavior,
            other.keyboardDismissBehavior,
          ),
          padding: assignIfNotNull(
            padding,
            other.padding,
          ),
          physics: assignIfNotNull(
            physics,
            other.physics,
          ),
          primary: assignIfNotNull(
            primary,
            other.primary,
          ),
          shrinkWrap: assignIfNotNull(
            shrinkWrap,
            other.shrinkWrap,
          ),
          scrollDirection: assignIfNotNull(
            scrollDirection,
            other.scrollDirection,
          ),
          semanticChildCount: assignIfNotNull(
            semanticChildCount,
            other.semanticChildCount,
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
          restorationId: assignIfNotNull(
            restorationId,
            other.restorationId,
          ),
          // hitTestBehavior: assignIfNotNull(
          //   hitTestBehavior,
          //   other.hitTestBehavior,
          // ),
          childAspectRatio: assignIfNotNull(
            childAspectRatio,
            other.childAspectRatio,
          ),
          crossAxisSpacing: assignIfNotNull(
            crossAxisSpacing,
            other.crossAxisSpacing,
          ),
          mainAxisSpacing: assignIfNotNull(
            mainAxisSpacing,
            other.mainAxisSpacing,
          ),
        );
      case GridConstructor.extent:
        return GridViewAttributes.extent(
          maxCrossAxisExtent: maxCrossAxisExtent, //copy prohibited
          reverse: assignIfNotNull(
            reverse,
            other.reverse,
          ),
          cacheExtent: assignIfNotNull(
            cacheExtent,
            other.cacheExtent,
          ),
          clipBehavior: assignIfNotNull(
            clipBehavior,
            other.clipBehavior,
          ),
          dragStartBehavior: assignIfNotNull(
            dragStartBehavior,
            other.dragStartBehavior,
          ),
          keyboardDismissBehavior: assignIfNotNull(
            keyboardDismissBehavior,
            other.keyboardDismissBehavior,
          ),
          padding: assignIfNotNull(
            padding,
            other.padding,
          ),
          physics: assignIfNotNull(
            physics,
            other.physics,
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
        return GridViewAttributes.builder(
          sliverGridDelegateKey: sliverGridDelegateKey, //copy prohibited
          childObjects: children,
          sliverGridDelegateOptions:
              sliverGridDelegateOptions, //copy prohibited
          scrollEndReachedThreshold: assignIfNotNull(
            scrollEndReachedThreshold,
            other.scrollEndReachedThreshold,
          ),
          mergeStrategy: mergeStrategy, //copy prohibited
          reverse: assignIfNotNull(
            reverse,
            other.reverse,
          ),
          cacheExtent: assignIfNotNull(
            cacheExtent,
            other.cacheExtent,
          ),
          clipBehavior: assignIfNotNull(
            clipBehavior,
            other.clipBehavior,
          ),
          dragStartBehavior: assignIfNotNull(
            dragStartBehavior,
            other.dragStartBehavior,
          ),
          keyboardDismissBehavior: assignIfNotNull(
            keyboardDismissBehavior,
            other.keyboardDismissBehavior,
          ),
          padding: assignIfNotNull(
            padding,
            other.padding,
          ),
          physics: assignIfNotNull(
            physics,
            other.physics,
          ),
          primary: assignIfNotNull(
            primary,
            other.primary,
          ),
          shrinkWrap: assignIfNotNull(
            shrinkWrap,
            other.shrinkWrap,
          ),
          scrollDirection: assignIfNotNull(
            scrollDirection,
            other.scrollDirection,
          ),
          semanticChildCount: assignIfNotNull(
            semanticChildCount,
            other.semanticChildCount,
          ),
          addAutomaticKeepAlives: assignIfNotNull(
            addAutomaticKeepAlives,
            other.addAutomaticKeepAlives,
          ),
          addRepaintBoundaries: assignIfNotNull(
            addRepaintBoundaries,
            other.addRepaintBoundaries,
          ),
        );
      case GridConstructor.common:
        return GridViewAttributes.common(
          sliverGridDelegateKey: sliverGridDelegateKey, //copy prohibited
          sliverGridDelegateOptions:
              sliverGridDelegateOptions, //copy prohibited
          reverse: assignIfNotNull(
            reverse,
            other.reverse,
          ),
          cacheExtent: assignIfNotNull(
            cacheExtent,
            other.cacheExtent,
          ),
          clipBehavior: assignIfNotNull(
            clipBehavior,
            other.clipBehavior,
          ),
          dragStartBehavior: assignIfNotNull(
            dragStartBehavior,
            other.dragStartBehavior,
          ),
          keyboardDismissBehavior: assignIfNotNull(
            keyboardDismissBehavior,
            other.keyboardDismissBehavior,
          ),
          padding: assignIfNotNull(
            padding,
            other.padding,
          ),
          physics: assignIfNotNull(
            physics,
            other.physics,
          ),
          primary: assignIfNotNull(
            primary,
            other.primary,
          ),
          shrinkWrap: assignIfNotNull(
            shrinkWrap,
            other.shrinkWrap,
          ),
          scrollDirection: assignIfNotNull(
            scrollDirection,
            other.scrollDirection,
          ),
          semanticChildCount: assignIfNotNull(
            semanticChildCount,
            other.semanticChildCount,
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
