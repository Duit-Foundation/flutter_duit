import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:example/src/registry_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

final class _Handler implements ExternalEventHandler {
  @override
  FutureOr<void> handleCustomEvent(
      BuildContext context, String key, Object? extra) {
    switch (key) {
      case "event1":
        {
          debugPrint("Event 1");
          break;
        }
      case "event2":
        {
          debugPrint("Event 2");
          break;
        }
    }
  }

  @override
  FutureOr<void> handleNavigation(
      BuildContext context, String path, Object? extra) {
    // TODO: implement handleNavigation
    throw UnimplementedError();
  }

  @override
  FutureOr<void> handleOpenUrl(String url) {
    // TODO: implement handleOpenUrl
    throw UnimplementedError();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DuitRegistry.register(
    "ExampleCustomWidget",
    modelFactory: modelMapperExample,
    buildFactory: exampleRenderer,
    attributesFactory: exampleAttributeMapper,
  );

  final worker = DuitWorkerPool();
  await worker.initWithConfiguration(
    DuitWorkerPoolConfiguration(
      workerCount: 6,
      policy: TaskDistributionPolicy.roundRobin,
    ),
  );

  DuitRegistry.registerWorkerPool(worker);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    driver1 = DuitDriver(
      "/inputs",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
      eventHandler: _Handler(),
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
            context: context,
            driver: driver1,
            placeholder: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
