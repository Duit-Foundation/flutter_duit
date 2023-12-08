import 'package:flutter/widgets.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element.dart';

/// Represents an abstract tree structure for rendering DUIT elements.
///
/// The [DUITAbstractTree] class provides a structure for representing and rendering DUIT elements.
/// It holds a JSON object representing the DUIT element tree, as well as a UIDriver for interacting with the UI.
/// The tree is parsed and stored as a [DUITElement] object, which can be rendered to a Flutter widget using the [render] method.
class DUITAbstractTree {
  /// The JSON object representing the DUIT element tree.
  @protected
  final JSONObject json;

  /// The UIDriver for interacting with the UI.
  @protected
  final UIDriver driver;

  /// The root [DUITElement] of the DUIT element tree.
  ///
  /// This property holds the root [DUITElement] object of the parsed DUIT element tree.
  /// It is created during the parsing process and is used for rendering the DUIT element tree to a Flutter widget.
  late final DUITElement _uiRoot;

  DUITAbstractTree({
    required this.json,
    required this.driver,
  });

  /// Parses the JSON object to create a [DUITElement] object tree.
  ///
  /// Returns a future that completes with the parsed [DUITAbstractTree] instance.
  Future<DUITAbstractTree> parse() async {
    _uiRoot = DUITElement.fromJson(json, driver);
    return this;
  }

  /// Renders the DUIT element tree to a Flutter widget.
  ///
  /// Returns the rendered Flutter widget.
  Widget render() {
    return _uiRoot.renderView();
  }
}
