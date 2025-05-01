import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';

import 'animation_context.dart';

mixin AnimatedAttributes on Widget {
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
      animatedProperties[prop] = animationContext.data[prop];
    }

    dataSource.addAll(animatedProperties);

    return dataSource;
  }
}
