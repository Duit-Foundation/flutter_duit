import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

import 'ui_driver.dart';

/// Represents an abstract tree structure for rendering DUIT elements.
///
/// The [DuitAbstractTree] class provides a structure for representing and rendering DUIT elements.
/// It holds a JSON object representing the DUIT element tree, as well as a UIDriver for interacting with the UI.
/// The tree is parsed and stored as a [DuitElement] object, which can be rendered to a Flutter widget using the [render] method.
abstract class DuitAbstractTree {
  /// The JSON object representing the DUIT element tree.
  @protected
  final Map<String, dynamic> json;

  /// The UIDriver for interacting with the UI.
  @protected
  final UIDriver driver;

  /// The root [DuitElement] of the DUIT element tree.
  ///
  /// This property holds the root [DuitElement] object of the parsed DUIT element tree.
  /// It is created during the parsing process and is used for rendering the DUIT element tree to a Flutter widget.
  late final DuitElement uiRoot;

  DuitAbstractTree({
    required this.json,
    required this.driver,
  });

  /// Parses the JSON object to create a [DuitElement] object tree.
  ///
  /// Returns a future that completes with the parsed [DuitAbstractTree] instance.
  Future<DuitAbstractTree> parse();

  /// Renders the DUIT element tree to a Flutter widget.
  ///
  /// Returns the rendered Flutter widget.
  Widget render();
}