// import "package:example/src/custom/example/attributes.dart";
// import "package:flutter/material.dart";
// import "package:flutter_duit/flutter_duit.dart";

// class ExampleWidget extends StatefulWidget {
//   final Widget? child;
//   final UIElementController<ExampleCustomWidgetAttributes> controller;

//   const ExampleWidget({
//     super.key,
//     required this.controller,
//     this.child,
//   });

//   @override
//   State<ExampleWidget> createState() => _ExampleWidgetState();
// }

// class _ExampleWidgetState extends State<ExampleWidget>
//     with
//         ViewControllerChangeListener<ExampleWidget,
//             ExampleCustomWidgetAttributes> {
//   @override
//   void initState() {
//     attachStateToController(
//       widget.controller,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green,
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         children: [
//           Text(attributes.random ?? ""),
//           widget.child ??
//               Container(
//                 color: Colors.red,
//                 width: 25,
//                 height: 25,
//               ),
//         ],
//       ),
//     );
//   }
// }
