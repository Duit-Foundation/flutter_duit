import 'dart:convert';
import 'dart:typed_data';
import 'package:example/src/custom/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class CustomDecoder extends Converter<Uint8List, Map<String, dynamic>> {
  @override
  Map<String, dynamic> convert(Uint8List input) {
    return jsonDecode(utf8.decode(input));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DuitRegistry.register(
    exampleCustomWidget,
    buildFactory: exampleBuildFactory,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duit Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final XDriver driver1;

  @override
  void initState() {
    driver1 = XDriver.static(
      {
        "type": "Text",
        "id": "1",
        "attributes": {
          "data": "Hello, World!",
        },
      },
      transportManager: StubTransportManager(),
    );
    super.initState();
  }

  @override
  void dispose() {
    driver1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: DuitViewHost.withDriver(
            driver: driver1,
          ),
        ),
      ),
    );
  }
}
