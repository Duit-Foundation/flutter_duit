import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DuitDisposableListTile extends StatefulWidget {
  final Future<DuitAbstractTree> layout;
  final UIDriver driver;
  final String id;

  const DuitDisposableListTile({
    super.key,
    required this.layout,
    required this.id,
    required this.driver,
  });

  @override
  State<DuitDisposableListTile> createState() => _DuitDisposableListTileState();
}

class _DuitDisposableListTileState extends State<DuitDisposableListTile> {
  @override
  void dispose() async {
    print(
        "Element out of view: controller assotiated with id - ${widget.id} was been disposed");
    widget.driver.detachController(widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.layout,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.render();
        } else if (snapshot.hasError) {
          return kDebugMode
              ? Text(snapshot.error.toString())
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class DuitListTile extends StatefulWidget {
  final Future<DuitAbstractTree> layout;
  final UIDriver driver;

  const DuitListTile({
    super.key,
    required this.layout,
    required this.driver,
  });

  @override
  State<DuitListTile> createState() => _DuitListTileState();
}

class _DuitListTileState extends State<DuitListTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.layout,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.render();
        } else if (snapshot.hasError) {
          return kDebugMode
              ? Text(snapshot.error.toString())
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
