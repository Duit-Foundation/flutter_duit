import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';

import 'animation_context.dart';

mixin AnimatedAttributes on Widget {
  /// Merges the [attributes] with the animated properties in the [DuitAnimationContext].
  @Deprecated("Use `mergeWithAttributes` instead")
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
