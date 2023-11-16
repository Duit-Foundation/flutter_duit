import 'package:flutter/material.dart';
import 'package:flutter_duit/src/transport/index.dart';

import 'duit_impl/index.dart';


void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final driver = DUITDriver(layoutSource: "ws://localhost:8999", transportType: TransportType.ws);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: Material(
        child: SafeArea(
          child: Column(
            children: [
              UIHostContainer(
                driver: driver,
              ),
              RepaintBoundary(
                child: TextButton(
                    onPressed: () {
                      // driver.updateAttributes();
                    },
                    child: const Text("LALALA")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
