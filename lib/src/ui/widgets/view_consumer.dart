import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/utils/index.dart";

mixin ConsumerState<T extends StatefulWidget> on State<T> {
  // final _itemCache = <String, Widget>{};
  late UIElementController _controller;
  List<Widget> children = [];

  void attachStateToController(UIElementController controller) {
    _controller = controller;

    final attrs = _controller.attributes.payload;
    final driver = _controller.driver;

    final childData = attrs.childObjects(key: "childObjects");
    final arr = childData.map((e) {
      final layoutTree = parseLayoutSync(
        e,
        driver,
      );

      return layoutTree.render();
    }).toList();

    children = arr;
  }

  Future<void> _listener() async {
    final attrs = _controller.attributes.payload;
    final driver = _controller.driver;

    final childData = attrs.childObjects(key: "childObjects");
    final arr = childData.map((e) {
      final layoutTree = parseLayoutSync(
        e,
        driver,
      );

      return layoutTree.render();
    }).toList();

    setState(() {
      children = arr;
    });
  }

  void _listenControllerUpdateStateEvent() {
    try {
      _controller.addListener(_listener);
    } catch (e) {
      // Controller might be disposed - skip adding listener
      return;
    }
  }

  @override
  void didChangeDependencies() {
    _listenControllerUpdateStateEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    try {
      _controller
        ..removeListener(_listener)
        ..detach();
    } catch (e) {
      // Controller might already be disposed - safe to ignore
    }
    super.dispose();
  }
}

class DuitViewConsumer extends StatefulWidget {
  final UIElementController controller;

  const DuitViewConsumer({
    required this.controller,
    super.key,
  });

  @override
  State<DuitViewConsumer> createState() => _DuitViewConsumerState();
}

class _DuitViewConsumerState extends State<DuitViewConsumer>
    with ConsumerState {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = widget.controller.attributes.payload;
    final type = attrs.getString(key: "type");

    // final childData = attrs.childObjects(key: "childObjects");

    // final driver = widget.controller.driver;
    // final arr = childData.map((e) {
    //   return buildOutOfBoundWidget(e, driver, null)!;
    //   // final id = e["id"];

    //   // if (_itemCache.containsKey(id)) {
    //   //   return _itemCache[id]!;
    //   // } else {
    //   //   final oobWidget = buildOutOfBoundWidget(
    //   //     e,
    //   //     widget.controller.driver,
    //   //     (child) => child,
    //   //   )!;

    //   //   _itemCache[id] = oobWidget;
    //   //   return oobWidget;
    //   // }
    // }).toList();

    // print("arr: ${arr.length}");

    return switch (type) {
      "column" => Column(
          key: ValueKey(widget.controller.id),
          children: children,
        ),
      "row" => Row(
          key: ValueKey(widget.controller.id),
          children: children,
        ),
      "stack" => Stack(
          key: ValueKey(widget.controller.id),
          children: children,
        ),
      "wrap" => Wrap(
          key: ValueKey(widget.controller.id),
          children: children,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
