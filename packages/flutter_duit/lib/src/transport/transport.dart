import 'dart:async';

abstract base class Transport {
  final String url;
  
  Transport(this.url);

  FutureOr<void> execute(String event, dynamic payload);

  Future<Map<String, dynamic>?> connect();

  void dispose();
}