import 'package:flutter_duit/flutter_duit.dart';

/// Abstract interface for sliver properties.
///
/// This interface is used to define properties for sliver-related attributes.
abstract interface class DuitSliverProps {
  abstract final bool needsBoxAdapter;
}

/// Abstract interface for sliver child delegate properties.
abstract interface class SliverChildDelegateProps {
  /// Whether the delegate is a [SliverChildBuilderDelegate].
  abstract final bool isBuilderDelegate;
  abstract final bool addAutomaticKeepAlives;
  abstract final bool addRepaintBoundaries;
  abstract final bool addSemanticIndexes;
  abstract final int? childCount;

  /// The children of the sliver.
  ///
  /// Used only when [isBuilderDelegate] is true.
  abstract final List<NonChildWidget>? childObjects;
}
