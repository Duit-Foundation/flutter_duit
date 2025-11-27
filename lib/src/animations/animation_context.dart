import "package:flutter/material.dart";

/// A context widget that provides animation streams to its child widgets.
///
/// This widget allows child widgets to access animation streams by their keys.
/// It is typically used in conjunction with animation controllers to provide
/// animated values to descendant widgets.
///
/// Example usage:
/// ```dart
/// DuitAnimationContext(
///   streams: {
///     'fade': fadeAnimation,
///     'slide': slideAnimation,
///   },
///   parentId: 'parent_widget_id',
///   child: MyAnimatedWidget(),
/// )
/// ```
///
/// Child widgets can access the animation streams using:
/// ```dart
/// final context = DuitAnimationContext.maybeOf(context);
/// final fadeAnimation = context?.streams['fade'];
/// ```
///
/// The [streams] parameter contains a map of animation keys to their corresponding
/// [Animation] objects. The [parentId] parameter identifies the parent widget
/// that owns these animations.
///
/// See also:
/// - [Animation], for the base animation class
/// - [InheritedWidget], for the base inherited widget class

class DuitAnimationContext extends InheritedWidget {
  final Map<String, Animation> streams;
  final String parentId;

  const DuitAnimationContext({
    required Widget child,
    required this.streams,
    required this.parentId,
    super.key,
  }) : super(child: child);

  static DuitAnimationContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DuitAnimationContext>();
  }

  @override
  bool updateShouldNotify(DuitAnimationContext oldWidget) {
    return this != oldWidget;
  }
}
