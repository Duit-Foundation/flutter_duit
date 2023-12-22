import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import './src/registry_example.dart';

void main() {
  DuitRegistry.register(
    "ExampleCustomWidget",
    modelMapperExample,
    exampleRenderer,
    exampleAttributeMapper,
  );
  runApp(const MyApp());
}

final driver1 = DuitDriver(
  "/decoratedbox",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
final driver2 = DuitDriver(
  "/inputs",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
final driver3 = DuitDriver(
  "ws://localhost:8999",
  transportOptions: WebSocketTransportOptions(),
);
final driver4 = DuitDriver(
  "/img",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
final driver5 = DuitDriver(
  "/stack",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
final driver6 = DuitDriver(
  "/updateExample",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
final driver7 = DuitDriver(
  "/gesture",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            DuitViewHost(
              context: context,
              driver: driver1,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver2,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver3,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver4,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 150,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: DuitViewHost(
                context: context,
                driver: driver5,
                placeholder: const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver6,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver7,
              placeholder: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
