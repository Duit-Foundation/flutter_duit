import "package:flutter/material.dart";

class DuitFittedBox extends StatelessWidget {
  final Widget child;

  const DuitFittedBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: child,
    );
  }
}
