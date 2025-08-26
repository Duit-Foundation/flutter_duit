import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

const _kBodyIndex = 0,
    _kAppBarIndex = 1,
    _kFabIndex = 2,
    _kBottomSheetIndex = 3,
    _kBottomNavInvdex = 4,
    _kPersistentButtonsFirstIndex = 5;

PreferredSizeWidget? _buildAppBar(List<Widget?> children) {
  final appBar = children.elementAtOrNull(_kAppBarIndex);
  return appBar is PreferredSizeWidget ? appBar : null;
}

final class DuitScaffold extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitScaffold({
    super.key,
    required this.attributes,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Scaffold(
      key: Key(attributes.id),
      body: children.elementAtOrNull(_kBodyIndex),
      appBar: _buildAppBar(children),
      floatingActionButton: children.elementAtOrNull(_kFabIndex),
      bottomSheet: children.elementAtOrNull(_kBottomSheetIndex),
      bottomNavigationBar: children.elementAtOrNull(_kBottomNavInvdex),
      persistentFooterButtons: children.length > _kPersistentButtonsFirstIndex
          ? children.sublist(_kPersistentButtonsFirstIndex).whereType<Widget>().toList()
          : null,
      floatingActionButtonLocation: attrs.fabLocation(),
      primary: attrs.getBool("primary", defaultValue: true),
      extendBody: attrs.getBool("extendBody"),
      extendBodyBehindAppBar: attrs.getBool("extendBodyBehindAppBar"),
      persistentFooterAlignment: attrs.alignmentDirectional(
        defaultValue: AlignmentDirectional.centerEnd,
      )!,
      restorationId: attrs.tryGetString("restorationId"),
      resizeToAvoidBottomInset: attrs.tryGetBool("resizeToAvoidBottomInset"),
      backgroundColor: attrs.tryParseColor(key: "backgroundColor"),
    );
  }
}

final class DuitControlledScaffold extends StatefulWidget {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledScaffold({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<DuitControlledScaffold> createState() => _DuitControlledScaffoldState();
}

class _DuitControlledScaffoldState extends State<DuitControlledScaffold>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.children;
    return Scaffold(
      key: Key(widget.controller.id),
      body: children.elementAtOrNull(_kBodyIndex),
      appBar: _buildAppBar(children),
      floatingActionButton: children.elementAtOrNull(_kFabIndex),
      bottomSheet: children.elementAtOrNull(_kBottomSheetIndex),
      bottomNavigationBar: children.elementAtOrNull(_kBottomNavInvdex),
      persistentFooterButtons: children.length > _kPersistentButtonsFirstIndex
          ? children.sublist(_kPersistentButtonsFirstIndex).whereType<Widget>().toList()
          : null,
      floatingActionButtonLocation: attributes.fabLocation(),
      primary: attributes.getBool("primary", defaultValue: true),
      extendBody: attributes.getBool("extendBody"),
      extendBodyBehindAppBar: attributes.getBool("extendBodyBehindAppBar"),
      persistentFooterAlignment: attributes.alignmentDirectional(
          defaultValue: AlignmentDirectional.centerEnd)!,
      restorationId: attributes.tryGetString("restorationId"),
      resizeToAvoidBottomInset:
          attributes.tryGetBool("resizeToAvoidBottomInset"),
      backgroundColor: attributes.tryParseColor(key: "backgroundColor"),
    );
  }
}
