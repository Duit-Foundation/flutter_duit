import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';
import 'package:example/src/registry_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DuitAnimationContext ctx = DuitAnimationContext.of(context);
    print(ctx.data.toString());
    return const Placeholder();
  }
}

class DuitAnimationContext extends InheritedWidget {
  final dynamic data;

  const DuitAnimationContext({
    super.key,
    required Widget child,
    required this.data,
  }) : super(child: child);

  static DuitAnimationContext of(BuildContext context) {
    final DuitAnimationContext? result =
        context.dependOnInheritedWidgetOfExactType<DuitAnimationContext>();
    assert(result != null, 'No DuitAnimationContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DuitAnimationContext oldWidget) {
    return this != oldWidget;
  }
}

class Descr {
  final String animatedPropKey;
  final num duration, from, to;

  const Descr({
    required this.animatedPropKey,
    required this.duration,
    required this.from,
    required this.to,
  });
}

class Anim extends StatefulWidget {
  final List<Descr> descrs;
  final Widget child;

  const Anim({
    super.key,
    required this.descrs,
    required this.child,
  });

  @override
  State<Anim> createState() => _AnimState();
}

class _AnimState extends State<Anim> with TickerProviderStateMixin {
  final Map<String, AnimationController> _controllers = {};
  final Map<String, Animation> _animations = {};

  @override
  void initState() {
    for (var element in widget.descrs) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: element.duration.toInt(),
        ),
      );

      final anim =
          Tween(begin: element.from, end: element.to).animate(controller);

      _animations[element.animatedPropKey] = anim;
      _controllers[element.animatedPropKey] = controller;
    }
    _controllers.forEach((_, value) {
      value.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((_, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        _animations.values.toList(),
      ),
      builder: (context, widget) {
        final dataObj = {};

        _animations.forEach((key, animation) {
          if (animation.status != AnimationStatus.completed) {
            dataObj[key] = animation.value;
          }
        });

        return DuitAnimationContext(
          data: dataObj,
          child: widget ?? const SizedBox.shrink(),
        );
      },
      child: widget.child,
    );
  }
}

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
      eventHandler: _Handler(),
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
      concurrentModeEnabled: true,
      // workerPool: DuitWorkerPool(),
      // workerPoolConfiguration: DuitWorkerPoolConfiguration(
      //   workerCount: 6,
      //   policy: TaskDistributionPolicy.sequential,
      // ),
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
      concurrentModeEnabled: true,
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
        // child: Anim(
        //   descrs: [
        //     Descr(
        //         animatedPropKey: "width", duration: 1000, from: 0.0, to: 200.0),
        //     Descr(
        //         animatedPropKey: "height", duration: 2000, from: 1.0, to: 3.0),
        //   ],
        //   child: TestWidget(),
        // ),
        // child: DuitViewHost(
        //   context: context,
        //   driver: driver1,
        //   placeholder: const CircularProgressIndicator(),
        // ),
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

class TestDisAnim extends StatefulWidget {
  const TestDisAnim({super.key});

  @override
  State<TestDisAnim> createState() => _TestDisAnimState();
}

class _TestDisAnimState extends State<TestDisAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ct;
  late final Animation _anim;

  @override
  void initState() {
    _ct = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _anim = Tween(begin: 0.0, end: 1.0).animate(_ct);
    _ct.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ct.reverse().whenComplete(() {
      _ct.dispose();
      super.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Opacity(
          opacity: _anim.value,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
