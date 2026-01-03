import 'dart:async';
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

  // final dio = Dio();

  // DuitRegistry.configure(
  //   logger: DefaultLogger.instance,
  //   themeLoader: HttpThemeLoader(
  //     dio,
  //     "http://localhost:8999/theme",
  //   ),
  // );

  // await DuitRegistry.initTheme();

  DuitRegistry.register(
    exampleCustomWidget,
    buildFactory: exampleBuildFactory,
  );

  // final res = await dio.get<List>("http://localhost:8999/components");

  // final comps = res.data!.cast<Map<String, dynamic>>();
  // await DuitRegistry.registerComponents(comps);

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
  late final DuitDriver driver1;

  @override
  void initState() {
    driver1 = DuitDriver.static(
      {
        "type": "Text",
        "id": "1",
        "attributes": {
          "data": "Hello, World!",
        },
      },
      transportOptions: EmptyTransportOptions(),
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
          child: DuitViewHost(
            driver: driver1,
          ),
        ),
      ),
    );
  }
}
