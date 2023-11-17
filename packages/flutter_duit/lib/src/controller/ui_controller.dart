import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/duit_impl/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';

///Base class for ViewController objects
abstract interface class UIElementController<T> {
  ///Typed attributes object (view properties)
  abstract ViewAttributeWrapper<T>? attributes;
  ///Id for current controller, same with [DUITElement] id
  abstract String id;
  ///Element type
  abstract DUITElementType type;
  ///Related action
  abstract ServerAction? action;
  ///Reference to the [DUITDriver] instance
  abstract UIDriver driver;


  ///Perform the action
  void performRelatedAction();

  ///Receive new attributes and set it to widget via setState method
  void updateState(ViewAttributeWrapper<T> newState);

  ///[ChangeNotifier] addListener method
  void addListener(VoidCallback listener);

  ///[ChangeNotifier] dispose method
  void dispose();
}
