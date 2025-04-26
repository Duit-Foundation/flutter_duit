// import "package:duit_kernel/duit_kernel.dart";
// import "package:flutter/material.dart";
// import "package:flutter_duit/src/animations/index.dart";
// import "package:flutter_duit/src/attributes/index.dart";
// import "package:flutter_duit/src/duit_impl/index.dart";

// class DuitPositioned extends StatelessWidget with AnimatedAttributes {
//   final ViewAttribute<PositionedAttributes> attributes;
//   final Widget child;

//   const DuitPositioned({
//     super.key,
//     required this.child,
//     required this.attributes,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final attrs = mergeWithAttributes(
//       context,
//       attributes.payload,
//     );
//     return Positioned(
//       key: Key(attributes.id),
//       top: attrs.top,
//       left: attrs.left,
//       right: attrs.right,
//       bottom: attrs.bottom,
//       child: child,
//     );
//   }
// }

// class DuitControlledPositioned extends StatefulWidget with AnimatedAttributes {
//   final UIElementController<PositionedAttributes> controller;
//   final Widget child;

//   const DuitControlledPositioned({
//     super.key,
//     required this.child,
//     required this.controller,
//   });

//   @override
//   State<DuitControlledPositioned> createState() =>
//       _DuitControlledPositionedState();
// }

// class _DuitControlledPositionedState extends State<DuitControlledPositioned>
//     with
//         ViewControllerChangeListener<DuitControlledPositioned,
//             PositionedAttributes> {
//   @override
//   void initState() {
//     attachStateToController(widget.controller);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final attrs = widget.mergeWithAttributes(
//       context,
//       attributes,
//     );

//     return Positioned(
//       key: Key(widget.controller.id),
//       top: attrs.top,
//       left: attrs.left,
//       right: attrs.right,
//       bottom: attrs.bottom,
//       child: widget.child,
//     );
//   }
// }
