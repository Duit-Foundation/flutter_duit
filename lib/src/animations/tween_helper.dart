import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

/// A mixin that provides helper methods for creating and animating tweens.
///
/// The `TweenHelper` mixin should be used with a `StatefulWidget` and its associated `State` class.
/// It provides utilities for creating Flutter [Tween] objects from [DuitTweenDescription] instances
/// and managing animation execution through [AnimationController] objects.
///
/// This mixin handles various tween types including:
/// - [ColorTween] for color animations
/// - [TextStyleTween] for text style animations
/// - [DecorationTween] for decoration animations
/// - [AlignmentTween] for alignment animations (with text direction support)
/// - [EdgeInsetsTween] for padding/margin animations (with text direction support)
/// - [BoxConstraintsTween] for constraint animations
/// - [SizeTween] for size animations
/// - [BorderTween] for border animations
/// - Generic [Tween] for numeric and other value types
///
/// See also:
/// - [DuitTweenDescription], for the base tween description class
/// - [AnimationController], for controlling animations
/// - [Tween], for the base tween class in Flutter
mixin TweenHelper<T extends StatefulWidget> on State<T> {
  TextDirection? _textDirection;

  Future<void> _handleToggleMethod(AnimationController controller) async {
    final isForwardOrCompleted = switch (controller.status) {
      AnimationStatus.completed || AnimationStatus.forward => true,
      AnimationStatus.dismissed || AnimationStatus.reverse => false,
    };

    if (isForwardOrCompleted) {
      await controller.reverse();
    } else {
      await controller.forward();
    }
  }

  /// Executes an animation using the specified method on the given controller.
  ///
  /// This method provides a unified interface for executing different animation
  /// methods (forward, reverse, repeat, toggle) on an [AnimationController].
  ///
  /// [method] - The animation method to execute (forward, reverse, repeat, or toggle)
  /// [controller] - The animation controller to execute the method on
  /// [reverseOnRepeat] - Whether to reverse the animation when repeating (only used with [AnimationMethod.repeat])
  ///
  /// Example:
  /// ```dart
  /// // Start animation forward
  /// await execAnimation(AnimationMethod.forward, controller);
  ///
  /// // Repeat animation with reverse
  /// await execAnimation(AnimationMethod.repeat, controller, reverseOnRepeat: true);
  ///
  /// // Toggle animation (forward if reversed, reverse if forward)
  /// await execAnimation(AnimationMethod.toggle, controller);
  /// ```
  ///
  /// See also:
  /// - [AnimationMethod], for available animation methods
  /// - [AnimationController], for the animation controller class
  Future<void> execAnimation(
    AnimationMethod method,
    AnimationController controller, [
    reverseOnRepeat = false,
  ]) async {
    switch (method) {
      case AnimationMethod.forward:
        controller.forward();
        break;
      case AnimationMethod.repeat:
        await controller.repeat(
          reverse: reverseOnRepeat,
        );
        break;
      case AnimationMethod.reverse:
        controller.reverse();
        break;
      case AnimationMethod.toggle:
        _handleToggleMethod(controller);
        break;
    }
  }

  /// Creates an [Animation] from a [Tween] with optional interval and curve configuration.
  ///
  /// This method wraps a [Tween] with a [CurvedAnimation] that applies the specified
  /// curve and optional interval to the animation. If an [interval] is provided, the
  /// animation will only be active during that portion of the controller's duration.
  ///
  /// [tween] - The tween to animate
  /// [controller] - The animation controller that drives the animation
  /// [interval] - Optional interval that defines when the animation is active (begin and end values between 0.0 and 1.0)
  /// [curve] - Optional curve for the animation easing (defaults to [Curves.linear] if not provided)
  ///
  /// Returns an [Animation] that can be used with Flutter's animation widgets.
  ///
  /// Example:
  /// ```dart
  /// final tween = Tween(begin: 0.0, end: 1.0);
  /// final animation = animate(
  ///   tween,
  ///   controller,
  ///   AnimationInterval(begin: 0.0, end: 0.5), // Only animate first half
  ///   Curves.easeInOut,
  /// );
  /// ```
  ///
  /// See also:
  /// - [Tween], for the base tween class
  /// - [CurvedAnimation], for the curved animation wrapper
  /// - [AnimationInterval], for interval configuration
  /// - [Curve], for animation curves
  @preferInline
  Animation<Object?> animate(
    Tween tween,
    AnimationController controller,
    AnimationInterval? interval,
    Curve? curve,
  ) {
    if (interval != null) {
      return tween.animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            interval.begin,
            interval.end,
            curve: curve ?? Curves.linear,
          ),
        ),
      );
    } else {
      return tween.animate(
        CurvedAnimation(
          parent: controller,
          curve: curve ?? Curves.linear,
        ),
      );
    }
  }

  /// Creates a Flutter [Tween] from a [DuitTweenDescription].
  ///
  /// This method converts a [DuitTweenDescription] instance into the appropriate
  /// Flutter [Tween] subclass based on the description type. It handles text direction
  /// resolution for [AlignmentTween] and [EdgeInsetsTween] to ensure proper RTL support.
  ///
  /// Supported tween description types:
  /// - [ColorTweenDescription] → [ColorTween]
  /// - [TextStyleTweenDescription] → [TextStyleTween]
  /// - [DecorationTweenDescription] → [DecorationTween]
  /// - [AlignmentTweenDescription] → [AlignmentTween] (with text direction resolution)
  /// - [EdgeInsetsTweenDescription] → [EdgeInsetsTween] (with text direction resolution)
  /// - [BoxConstraintsTweenDescription] → [BoxConstraintsTween]
  /// - [SizeTweenDescription] → [SizeTween]
  /// - [BorderTweenDescription] → [BorderTween]
  /// - [TweenDescription] → Generic [Tween]
  ///
  /// [animation] - The tween description to convert
  ///
  /// Returns a [Tween] instance that can be used with [animate] method.
  ///
  /// Throws [UnimplementedError] if the tween description type is not supported.
  ///
  /// Example:
  /// ```dart
  /// final colorDescription = ColorTweenDescription(
  ///   animatedPropKey: 'backgroundColor',
  ///   duration: Duration(milliseconds: 300),
  ///   begin: Colors.red,
  ///   end: Colors.blue,
  ///   curve: Curves.easeInOut,
  ///   trigger: AnimationTrigger.onTap,
  ///   method: AnimationMethod.forward,
  ///   reverseOnRepeat: false,
  /// );
  ///
  /// final tween = createTweenFrom(colorDescription);
  /// final animation = animate(tween, controller, null, Curves.easeInOut);
  /// ```
  ///
  /// See also:
  /// - [DuitTweenDescription], for the base tween description class
  /// - [Tween], for the base tween class
  /// - [animate], for creating an animation from a tween
  @preferInline
  Tween createTweenFrom(
    DuitTweenDescription animation,
  ) {
    _textDirection ??= Directionality.of(context);

    return switch (animation) {
      ColorTweenDescription(
        :final begin,
        :final end,
      ) =>
        ColorTween(
          begin: begin,
          end: end,
        ),
      TweenDescription(
        :final begin,
        :final end,
      ) =>
        Tween(
          begin: begin,
          end: end,
        ),
      TextStyleTweenDescription(
        :final begin,
        :final end,
      ) =>
        TextStyleTween(
          begin: begin,
          end: end,
        ),
      DecorationTweenDescription(
        :final begin,
        :final end,
      ) =>
        DecorationTween(
          begin: begin,
          end: end,
        ),
      AlignmentTweenDescription(
        :final begin,
        :final end,
      ) =>
        AlignmentTween(
          begin: begin.resolve(_textDirection),
          end: end.resolve(_textDirection),
        ),
      EdgeInsetsTweenDescription(
        :final begin,
        :final end,
      ) =>
        EdgeInsetsTween(
          begin: begin.resolve(_textDirection),
          end: end.resolve(_textDirection),
        ),
      BoxConstraintsTweenDescription(
        :final begin,
        :final end,
      ) =>
        BoxConstraintsTween(
          begin: begin,
          end: end,
        ),
      SizeTweenDescription(
        :final begin,
        :final end,
      ) =>
        SizeTween(
          begin: begin,
          end: end,
        ),
      BorderTweenDescription(
        :final begin,
        :final end,
      ) =>
        BorderTween(
          begin: begin,
          end: end,
        ),
      _ => throw UnimplementedError(
          "Tween of type ${animation.runtimeType} is not implemented",
        ),
    };
  }
}
