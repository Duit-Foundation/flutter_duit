import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';

final class DisposableListTile extends StatefulWidget {
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

final class CommonListTile extends StatelessWidget {
  final Widget child;

  const CommonListTile({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
