import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/utils/index.dart';

///Base class for Attributes object
///
///Defines view properties that can be retrieved from the server or updated
base class Attributes<T> {
  ///Optional type definition
  final String? type;

  ///Declaring a payload property to be overridden in inheriting classes
  T payload;

  Attributes({
    this.type,
    required this.payload,
  });

  static Attributes<T>? create<T>(T payload) {
    return Attributes<T>(payload: payload);
  }
}
