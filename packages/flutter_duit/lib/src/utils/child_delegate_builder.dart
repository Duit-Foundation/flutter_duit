import "package:flutter/material.dart";

mixin ChildDelegateBuilder {
  SliverChildDelegate buildDelegate(
    bool isBuilderDelegate, {
    List<Widget> children = const [],
    NullableIndexedWidgetBuilder? builder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    int? childCount,
    int semanticIndexOffset = 0,
  }) {
    if (isBuilderDelegate) {
      return SliverChildBuilderDelegate(
        builder!,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        semanticIndexOffset: semanticIndexOffset,
        childCount: childCount,
      );
    } else {
      return SliverChildListDelegate(
        children,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        semanticIndexOffset: semanticIndexOffset,
      );
    }
  }
}
