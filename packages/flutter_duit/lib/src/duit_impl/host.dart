import 'package:flutter/material.dart';

import 'driver.dart';

class UIHostContainer extends StatefulWidget {
  final Widget? placeholder;
  final DUITDriver driver;
  final BuildContext context;

  const UIHostContainer({
    super.key,
    required this.driver,
    required this.context,
    this.placeholder,
  });

  @override
  State<UIHostContainer> createState() => _UIHostContainerState();
}

class _UIHostContainerState extends State<UIHostContainer> {
  Widget? _widget;

  @override
  void initState() {
    widget.driver.init().then((res) {
      if (res != null) {
        setState(() {
          _widget = res.render();
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.driver.context = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_widget == null) {
      return widget.placeholder ?? const SizedBox.shrink();
    } else {
      return _widget!;
    }
  }
}
