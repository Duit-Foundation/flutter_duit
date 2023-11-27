import 'package:flutter/material.dart';

import 'driver.dart';

class DuitViewHost extends StatefulWidget {
  final Widget? placeholder;
  final UIDriver driver;
  final BuildContext context;

  const DuitViewHost({
    super.key,
    required this.driver,
    required this.context,
    this.placeholder,
  });

  @override
  State<DuitViewHost> createState() => _DuitViewHostState();
}

class _DuitViewHostState extends State<DuitViewHost> {

  @override
  void initState() {
    widget.driver.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.driver.stream,
        builder: (context, snapshot) {
          widget.driver.context = context;

          if (snapshot.data != null) {
            return snapshot.data!.render();
          } else {
            return widget.placeholder ?? const SizedBox.shrink();
          }
        });
  }
}
