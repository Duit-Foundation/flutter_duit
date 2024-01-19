import 'package:duit_kernel/duit_kernel.dart';
import 'package:example/src/registry_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DuitRegistry.register(
    "ExampleCustomWidget",
    modelMapperExample,
    exampleRenderer,
    exampleAttributeMapper,
  );

  DuitRegistry.registerComponents([
    {
      "tag": "shoes_card",
      "layoutRoot": {
        "controlled": false,
        "action": null,
        "id": "57c52093-d7cb-4d6b-a26b-c9527fb83435",
        "type": "DecoratedBox",
        "attributes": {
          "decoration": {
            "color": "#DCDCDC",
            "borderRadius": 8,
            "boxShadow": [
              {
                "color": "#a0a0a0",
                "offset": {"dx": 2, "dy": 2},
                "blurRadius": 2,
                "spreadRadius": 2
              }
            ]
          }
        },
        "child": {
          "controlled": false,
          "action": null,
          "id": "5e3e3ded-681d-4811-b154-7a08c0343d7d",
          "type": "Padding",
          "attributes": {"padding": 16},
          "child": {
            "controlled": false,
            "action": null,
            "id": "f9273bab-1d76-4656-970e-dbe9a069eb7b",
            "children": [
              {
                "controlled": false,
                "action": null,
                "id": "2e57fa4c-1ebf-4ffc-9e86-f910c5217e2f",
                "type": "Image",
                "attributes": {
                  "type": "network",
                  "height": 68,
                  "width": 68,
                  "src": "",
                  "fit": "contain",
                  "refs": [
                    {"attributeKey": "src", "objectKey": "image"}
                  ]
                }
              },
              {
                "controlled": false,
                "action": null,
                "id": "d7da76c0-5b87-45cb-b412-c806b6ceab53",
                "type": "SizedBox",
                "attributes": {"width": 16}
              },
              {
                "controlled": false,
                "action": null,
                "id": "b2943849-14bc-4833-a9c2-d0765a3e78bf",
                "children": [
                  {
                    "controlled": false,
                    "action": null,
                    "id": "6d35ab28-89a7-408c-9fdf-7b0579700971",
                    "type": "Text",
                    "attributes": {
                      "style": {
                        "fontSize": 24,
                        "fontWeight": 700,
                        "color": "#8a8a8a"
                      },
                      "refs": [
                        {"attributeKey": "data", "objectKey": "primary"}
                      ]
                    }
                  },
                  {
                    "controlled": false,
                    "action": null,
                    "id": "b00d564b-b71f-4f6b-a498-753a5d10c667",
                    "type": "Text",
                    "attributes": {
                      "style": {
                        "fontSize": 16,
                        "fontWeight": 400,
                        "color": "#6798e6"
                      },
                      "refs": [
                        {"attributeKey": "data", "objectKey": "description"}
                      ]
                    }
                  },
                  {
                    "controlled": false,
                    "action": null,
                    "id": "dedc7b32-ac3c-4d61-ac24-aeca1dc478db",
                    "type": "Text",
                    "attributes": {
                      "style": {
                        "fontSize": 16,
                        "fontWeight": 500,
                        "color": [0, 0, 0, 1]
                      },
                      "refs": [
                        {"attributeKey": "data", "objectKey": "cost"}
                      ]
                    }
                  }
                ],
                "type": "Column",
                "attributes": {
                  "mainAxisAlignment": "spaceEvenly",
                  "crossAxisAlignment": "end"
                }
              }
            ],
            "type": "Row",
            "attributes": {"mainAxisAlignment": "spaceBetween"}
          }
        }
      }
    },
  ]);
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
  late final DuitDriver driver2;
  late final DuitDriver driver3;
  late final DuitDriver driver4;
  late final DuitDriver driver5;
  late final DuitDriver driver6;
  late final DuitDriver driver7;
  late final DuitDriver driver8;
  late final DuitDriver driver9;
  late final DuitDriver driver10;
  late final DuitDriver driver11;

  @override
  void initState() {
    driver1 = DuitDriver(
      "/decoratedbox",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver1 INIT");
      };
    driver2 = DuitDriver(
      "/inputs",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )
      ..onInit = () {
        print("driver2 INIT");
      }
      ..beforeActionCallback = (action) {
        print(action.event);
      }
      ..afterActionCallback = () {
        print("Action handled");
      }
      ..onEventReceived = (event) {
        print(event?.type);
      };
    driver3 = DuitDriver(
      "ws://localhost:8999",
      transportOptions: WebSocketTransportOptions(),
    )..onInit = () {
        print("driver3 INIT");
      };
    driver4 = DuitDriver(
      "/img",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver4 INIT");
      };
    driver5 = DuitDriver(
      "/stack",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver5 INIT");
      };
    driver6 = DuitDriver(
      "/updateExample",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver6 INIT");
      };
    driver7 = DuitDriver(
      "/gesture",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver7 INIT");
      };
    driver8 = DuitDriver(
      "/transform",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver8 INIT");
      };
    driver9 = DuitDriver(
      "/rich",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver9 INIT");
      };

    driver10 = DuitDriver(
      "/shoes",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver10 INIT");
      };

    driver11 = DuitDriver(
      "/scrollview",
      transportOptions: HttpTransportOptions(
        defaultHeaders: {"Content-Type": "application/json"},
        baseUrl: "http://localhost:8999",
      ),
    )..onInit = () {
        print("driver11 INIT");
      };
    super.initState();
  }

  @override
  void dispose() {
    driver1.dispose();
    driver2.dispose();
    driver3.dispose();
    driver4.dispose();
    driver5.dispose();
    driver6.dispose();
    driver7.dispose();
    driver8.dispose();
    driver9.dispose();
    driver10.dispose();
    driver11.dispose();
    super.dispose();
  }

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
              gestureInterceptor: (type, {gestureInfo}) {
                debugPrint(type.name);
              },
              gestureInterceptorBehavior:
                  GestureInterceptorBehavior.onlyWithAction,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver8,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 48,
            ),
            DuitViewHost(
              context: context,
              driver: driver9,
              placeholder: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DuitViewHost(
                context: context,
                driver: driver10,
                placeholder: const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            DuitViewHost(
              context: context,
              driver: driver11,
              placeholder: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
