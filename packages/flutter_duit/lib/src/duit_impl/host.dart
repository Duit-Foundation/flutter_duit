import 'package:flutter/material.dart';

import 'driver.dart';

class UIHostContainer extends StatefulWidget {
  final Widget? placeholder;
  final DUITDriver driver;

  const UIHostContainer({
    super.key,
    required this.driver,
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
  Widget build(BuildContext context) {
    if (_widget == null) {
      return widget.placeholder ?? const SizedBox.shrink();
    } else {
      return _widget!;
    }
  }
}