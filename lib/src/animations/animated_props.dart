import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';

import 'animation_context.dart';

mixin AnimatedPropertiesMixin on Widget {
  T wrapAttributes<T>(
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

    final animatedProperties = <String, dynamic>{};

    if (attributes.affectedProperties == null ||
        attributes.affectedProperties!.isEmpty) {
      return attributes;
    }

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
