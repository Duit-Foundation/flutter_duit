import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';

import 'animation_context.dart';

mixin AnimatedAttributes on Widget {
  @Deprecated("Will be removed in next major version")
  T mergeWithController<T>(
    BuildContext context,
    UIElementController<T> controller,
  ) {
    return mergeWithAttributes<T>(
      context,
      controller.attributes.payload,
    );
  }

  /// Merges the [attributes] with the animated properties in the [DuitAnimationContext].
  T mergeWithAttributes<T>(
    BuildContext context,
    T attributes,
  ) {
    if (attributes is! AnimatedPropertyOwner) {
      return attributes;
    }

    if (attributes.parentBuilderId == null) {
      return attributes;
    }

    final animationContext = DuitAnimationContext.maybeOf(context);
    if (animationContext == null) {
      return attributes;
    }

    if (animationContext.parentId != attributes.parentBuilderId) {
      return attributes;
    }

    if (attributes.affectedProperties == null ||
        attributes.affectedProperties!.isEmpty) {
      return attributes;
    }

    final animatedProperties = <String, dynamic>{};

    for (final prop in attributes.affectedProperties!) {
      animatedProperties[prop] = animationContext.data[prop];
    }

    final dA = attributes as DuitAttributes;

    final newAttr = dA.dispatchInternalCall<DuitAttributes>(
      "fromJson",
      positionalParams: [
        animatedProperties,
      ],
    );

    return dA.copyWith(newAttr);
  }
}
