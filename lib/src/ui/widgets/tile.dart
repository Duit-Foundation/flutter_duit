import 'package:flutter/cupertino.dart';

// The widget acts as a wrapper that creates keys for components when using lists
final class DuitTile extends StatelessWidget {
  final Widget child;

  DuitTile({
    required this.child,
    required String id,
  }) : super(key: ValueKey(id));

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
