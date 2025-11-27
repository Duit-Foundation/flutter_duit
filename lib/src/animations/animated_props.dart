import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

import "package:flutter_duit/src/animations/animation_context.dart";

//TOOD: doc it
mixin AnimatedAttributes on Widget {
  /// Merges the [attributes] with the animated properties in the [DuitAnimationContext].
  DuitDataSource mergeWithDataSource(
    BuildContext context,
    DuitDataSource dataSource,
  ) {
    final parentId = dataSource.parentBuilderId;

    if (parentId == null) {
      return dataSource;
    }

    final animationContext = DuitAnimationContext.maybeOf(context);
    if (animationContext == null) {
      return dataSource;
    }

    if (animationContext.parentId != parentId) {
      return dataSource;
    }

    final affectedProps = dataSource.affectedProperties;

    if (affectedProps == null || affectedProps.isEmpty) {
      return dataSource;
    }

    final animatedProperties = <String, dynamic>{};

    for (final prop in affectedProps) {
      final value = animationContext.streams[prop]?.value;
      if (value != null) {
        animatedProperties[prop] = value;
      }
    }

    return dataSource..addAll(animatedProperties);
  }
}
