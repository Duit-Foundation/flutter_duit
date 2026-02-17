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
  Widget ccc = Container(
    color: Colors.red,
    width: 100,
    height: 100,
    key: const ValueKey("ccc1"),
  );

  @override
  void initState() {
    driver1 = XDriver.static(
      {
        "type": "Column",
        "id": "root",
        "controlled": false,
        "attributes": {
          "mainAxisAlignment": "spaceBetween",
          "crossAxisAlignment": "stretch"
        },
        "children": [
          {
            "type": "Subtree",
            "id": "header_section",
            "controlled": true,
            "child": {
              "type": "SkeletonBox",
              "id": "skeleton_header",
              "attributes": {"width": 300, "height": 40}
            }
          },
          {
            "type": "Subtree",
            "id": "content_section",
            "controlled": true,
            "child": {
              "type": "SkeletonBox",
              "id": "skeleton_content",
              "attributes": {"width": 300, "height": 120}
            }
          },
          {
            "type": "Subtree",
            "id": "action_section",
            "controlled": true,
            "child": {
              "type": "SkeletonBox",
              "id": "skeleton_action",
              "attributes": {"width": 200, "height": 48}
            }
          }
        ]
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
                onPressed: () {
                  driver1.addExternalEventStream(Stream.value({
                    "type": "sequenced",
                    "events": [
                      {
                        "delay": 0,
                        "event": {
                          "type": "update",
                          "updates": {
                            "header_section": {
                              "type": "Text",
                              "id": "header_text",
                              "controlled": false,
                              "attributes": {"data": "Заголовок"}
                            }
                          }
                        },
                      },
                      {
                        "delay": 0,
                        "event": {
                          "type": "update",
                          "updates": {
                            "content_section": {
                              "type": "Text",
                              "id": "content_text",
                              "controlled": false,
                              "attributes": {"data": "Основной контент"}
                            }
                          }
                        }
                      },
                      {
                        "delay": 0,
                        "event": {
                          "type": "update",
                          "updates": {
                            "action_section": {
                              "type": "ElevatedButton",
                              "id": "action_btn",
                              "controlled": true,
                              "child": {
                                "type": "Text",
                                "id": "btn_text",
                                "controlled": false,
                                "attributes": {"data": "Готово"}
                              }
                            }
                          }
                        }
                      }
                    ]
                  }));
                },
                child: const Text("Update")),
            Expanded(
              child: DuitViewHost.withDriver(
                driver: driver1,
                // customSkeletonBuilder: (w, h) => _SkeletonBox(
                //   size: Size(w, h),
                // ),
              ),
            ),
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 3000),
            //   reverseDuration: const Duration(milliseconds: 3000),
            //   child: ccc,
            // ),
            // TextButton(
            //     onPressed: () {
            //       setState(() {
            //         ccc = Container(
            //           color: Colors.blue,
            //           width: 50,
            //           height: 50,
            //           key: const ValueKey("ccc2"),
            //         );
            //       });
            //     },
            //     child: const Text("Change"))
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatefulWidget {
  final Size size;

  const _SkeletonBox({
    required this.size,
  });

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animation = ColorTween(
      begin: Colors.black.withAlpha(51),
      end: Colors.grey.withAlpha(51),
    ).animate(
      _controller,
    );

    _controller.repeat(reverse: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
            color: _animation.value ?? Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        );
      },
    );
  }
}
