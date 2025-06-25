import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/slivers/sliver_props.dart';

final class SliverVisibilityAttributes
    implements DuitAttributes<SliverVisibilityAttributes>, DuitSliverProps {
  final bool visible,
      maintainState,
      maintainAnimation,
      maintainSize,
      maintainSemantics,
      maintainInteractivity;
  final NonChildWidget? replacementSliver;

  @override
  final bool needsBoxAdapter;

  const SliverVisibilityAttributes({
    required this.visible,
    required this.maintainState,
    required this.maintainAnimation,
    required this.maintainSize,
    required this.maintainSemantics,
    required this.maintainInteractivity,
    required this.needsBoxAdapter,
    required this.replacementSliver,
  });

  factory SliverVisibilityAttributes.fromJson(Map<String, dynamic> json) {
    return SliverVisibilityAttributes(
      visible: json["visible"] ?? true,
      maintainState: json["maintainState"] ?? false,
      maintainAnimation: json["maintainAnimation"] ?? false,
      maintainSize: json["maintainSize"] ?? false,
      maintainSemantics: json["maintainSemantics"] ?? false,
      maintainInteractivity: json["maintainInteractivity"] ?? false,
      replacementSliver: json["replacementSliver"],
      needsBoxAdapter: json["needsBoxAdapter"] ?? false,
    );
  }

  @override
  SliverVisibilityAttributes copyWith(SliverVisibilityAttributes other) {
    return SliverVisibilityAttributes(
      visible: other.visible,
      maintainState: other.maintainState,
      maintainAnimation: other.maintainAnimation,
      maintainSize: other.maintainSize,
      maintainSemantics: other.maintainSemantics,
      maintainInteractivity: other.maintainInteractivity,
      replacementSliver: other.replacementSliver,
      needsBoxAdapter: needsBoxAdapter,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError();
}
