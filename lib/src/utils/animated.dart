import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_duit/src/attributes/animation_attributes/animated_attributes_holder.dart';
import 'package:flutter_duit/src/ui/widgets/explicit/animation_context.dart';

mixin AnimatedPropertiesMixin {
  T wrapAttributes<T extends AnimatedPropertyOwner>(
      BuildContext context, T attributes) {
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

    return attributes;
  }
}
