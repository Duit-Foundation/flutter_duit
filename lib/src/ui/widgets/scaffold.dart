import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class DuitScaffold extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitScaffold({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<DuitScaffold> createState() => _DuitScaffoldState();
}

class _DuitScaffoldState extends State<DuitScaffold>
    with ViewControllerChangeListener, OutOfBoundWidgetBuilder {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driver = widget.controller.driver;
    return Scaffold(
      key: Key(widget.controller.id),
      appBar: buildOutOfBoundWidget(
        attributes["appBar"],
        driver,
        null,
      ),
      body: widget.child,
      floatingActionButton: buildOutOfBoundWidget(
        attributes["floatingActionButton"],
        driver,
        null,
      ),
      bottomSheet: buildOutOfBoundWidget(
        attributes["bottomSheet"],
        driver,
        null,
      ),
      bottomNavigationBar: buildOutOfBoundWidget(
        attributes["bottomNavigationBar"],
        driver,
        null,
      ),
      floatingActionButtonLocation: attributes.fabLocation(),
      primary: attributes.getBool("primary", defaultValue: true),
      extendBody: attributes.getBool("extendBody"),
      extendBodyBehindAppBar: attributes.getBool("extendBodyBehindAppBar"),
      persistentFooterAlignment: attributes.alignmentDirectional(
          defaultValue: AlignmentDirectional.centerEnd)!,
      persistentFooterButtons: (attributes["persistentFooterButtons"] as List?)
          ?.map((e) => buildOutOfBoundWidget(e, driver, null))
          .whereType<Widget>()
          .toList(),
      restorationId: attributes.tryGetString("restorationId"),
      resizeToAvoidBottomInset:
          attributes.tryGetBool("resizeToAvoidBottomInset"),
      backgroundColor: attributes.tryParseColor(key: "backgroundColor"),
    );
  }
}
