import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';

class DisposableListTile extends StatefulWidget {
  final UIDriver driver;
  final Widget child;
  final String id;

  const DisposableListTile({
    super.key,
    required this.id,
    required this.child,
    required this.driver,
  });

  @override
  State<DisposableListTile> createState() => _DisposableListTileState();
}

class _DisposableListTileState extends State<DisposableListTile> {
  @override
  void dispose() async {
    widget.driver.detachController(widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class CommonListTile extends StatefulWidget {
  final Widget child;
  final UIDriver driver;

  const CommonListTile({
    super.key,
    required this.child,
    required this.driver,
  });

  @override
  State<CommonListTile> createState() => _CommonListTileState();
}

class _CommonListTileState extends State<CommonListTile> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
