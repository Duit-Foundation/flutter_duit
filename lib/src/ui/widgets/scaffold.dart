import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/attributes/index.dart';

class DuitScaffold extends StatefulWidget {
  final UIElementController<ScaffoldAttributes> controller;

  const DuitScaffold({
    super.key,
    required this.controller,
  });

  @override
  State<DuitScaffold> createState() => _DuitScaffoldState();
}

class _DuitScaffoldState extends State<DuitScaffold>
    with
        ViewControllerChangeListener<DuitScaffold, ScaffoldAttributes>,
        OutOfBoundWidgetBuilder {
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
        attributes.appBar,
        driver,
        null,
      ),
      body: buildOutOfBoundWidget(
        attributes.appBar,
        driver,
        null,
      ),
      floatingActionButton: buildOutOfBoundWidget(
        attributes.floatingActionButton,
        driver,
        null,
      ),
      bottomSheet: buildOutOfBoundWidget(
        attributes.bottomSheet,
        driver,
        null,
      ),
      bottomNavigationBar: buildOutOfBoundWidget(
        attributes.bottomNavigationBar,
        driver,
        null,
      ),
      floatingActionButtonLocation: attributes.floatingActionButtonLocation,
      primary: attributes.primary,
      extendBody: attributes.extendBody,
      extendBodyBehindAppBar: attributes.extendBodyBehindAppBar,
      persistentFooterAlignment: attributes.persistentFooterAlignment,
      persistentFooterButtons: attributes.persistentFooterButtons
          ?.map((e) => buildOutOfBoundWidget(e, driver, null))
          .whereType<Widget>()
          .toList(),
      restorationId: attributes.restorationId,
      resizeToAvoidBottomInset: attributes.resizeToAvoidBottomInset,
      backgroundColor: attributes.backgroundColor,
    );
  }
}
