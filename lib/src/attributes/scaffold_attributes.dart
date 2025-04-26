import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class ScaffoldAttributes implements DuitAttributes<ScaffoldAttributes> {
  //TODO: implement Drawer and related props
  final NonChildWidget? appBar,
      bottomNavigationBar,
      floatingActionButton,
      bottomSheet;
  // final NonChildWidget? drawer;
  // final NonChildWidget? endDrawer;
  final Color? backgroundColor;
  final bool extendBody, extendBodyBehindAppBar, primary;
  final bool? resizeToAvoidBottomInset;
  final AlignmentDirectional persistentFooterAlignment;
  final List<NonChildWidget>? persistentFooterButtons;
  final String? restorationId;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ScaffoldAttributes({
    required this.extendBody,
    required this.extendBodyBehindAppBar,
    required this.primary,
    required this.persistentFooterAlignment,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    // this.drawer,
    // this.endDrawer,
    this.floatingActionButton,
    this.bottomSheet,
    this.persistentFooterButtons,
    this.restorationId,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset,
  });

  factory ScaffoldAttributes.fromJson(Map<String, dynamic> json) {
    return ScaffoldAttributes(
      extendBody: json["extendBody"] ?? false,
      extendBodyBehindAppBar: json["extendBodyBehindAppBar"] ?? false,
      primary: json["primary"] ?? true,
      appBar: json["appBar"],
      backgroundColor:
          ColorUtils.tryParseNullableColor(json["backgroundColor"]),
      bottomNavigationBar: json["bottomNavigationBar"],
      // drawer: json["drawer"],
      // endDrawer: json["endDrawer"],
      floatingActionButton: json["floatingActionButton"],
      bottomSheet: json["bottomSheet"],
      persistentFooterAlignment: AttributeValueMapper.toAlignmentDirectional(
        json["persistentFooterAlignment"],
      ),
      persistentFooterButtons: (json["persistentFooterButtons"] as List?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      floatingActionButtonLocation: AttributeValueMapper.toFABLocation(
        json["floatingActionButtonLocation"],
      ),
      restorationId: json["restorationId"],
      resizeToAvoidBottomInset: json["resizeToAvoidBottomInset"],
    );
  }

  @override
  ScaffoldAttributes copyWith(other) {
    return ScaffoldAttributes(
        extendBody: other.extendBody,
        extendBodyBehindAppBar: other.extendBodyBehindAppBar,
        primary: other.primary,
        appBar: other.appBar ?? appBar,
        backgroundColor: other.backgroundColor ?? backgroundColor,
        bottomNavigationBar: other.bottomNavigationBar ?? bottomNavigationBar,
        // drawer: other.drawer ?? drawer,
        // endDrawer: other.endDrawer ?? endDrawer,
        floatingActionButton:
            other.floatingActionButton ?? floatingActionButton,
        bottomSheet: other.bottomSheet ?? bottomSheet,
        persistentFooterAlignment: other.persistentFooterAlignment,
        persistentFooterButtons:
            other.persistentFooterButtons ?? persistentFooterButtons,
        restorationId: other.restorationId ?? restorationId,
        floatingActionButtonLocation:
            other.floatingActionButtonLocation ?? floatingActionButtonLocation,
        resizeToAvoidBottomInset:
            other.resizeToAvoidBottomInset ?? resizeToAvoidBottomInset);
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) =>
      throw UnimplementedError("$methodName is not implemented");
}
