import "package:flutter/material.dart";
import "package:flutter_duit/kernel_api.dart";
import "package:flutter_duit/src/duit_impl/view_context.dart";

class DuitSkeletonBox extends StatelessWidget {
  final ViewAttribute attributes;

  DuitSkeletonBox({
    required this.attributes,
  }) : super(key: ValueKey(attributes.id));

  @override
  Widget build(BuildContext context) {
    final customSkeletonBuilder =
        DuitViewContext.of(context).customSkeletonBuilder;

    if (customSkeletonBuilder != null) {
      return customSkeletonBuilder.build(
        attributes.payload.toEnum(
          key: "type",
          typeArg: customSkeletonBuilder.underlayingTypeArgument,
        ),
        attributes.payload,
      );
    }

    return Placeholder(
      child: SizedBox(
        width: attributes.payload.tryGetDouble(
          key: "width",
          defaultValue: 100,
        ),
        height: attributes.payload.tryGetDouble(
          key: "height",
          defaultValue: 100,
        ),
      ),
    );
  }
}
