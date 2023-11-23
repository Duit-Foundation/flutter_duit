import 'dart:async';

import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/duit_impl/widgets_update_set.dart';

abstract base class Transport {
  final String url;
  
  Transport(this.url);

  FutureOr<WidgetsUpdateSet?> execute(ServerAction action, Map<String, dynamic> payload);

  Future<Map<String, dynamic>?> connect();

  void dispose();
}