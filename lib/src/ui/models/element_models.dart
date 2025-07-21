// import 'package:duit_kernel/duit_kernel.dart';
// import 'package:flutter_duit/src/ui/models/element.dart';
// import 'package:flutter_duit/src/ui/models/element_type.dart';
// import "package:flutter_duit/src/ui/models/child.dart";

// final class MetaUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   MetaUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class SingleChildScrollviewUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   SingleChildScrollviewUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class IgnorePointerUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   IgnorePointerUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class OpacityUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   OpacityUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class LifecycleStateListenerUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   LifecycleStateListenerUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class RadioGroupContextUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   RadioGroupContextUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class TransformUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   TransformUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class AlignUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   AlignUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class GestureDetectorUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   GestureDetectorUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class ContainerUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ContainerUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class DecoratedBoxUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   DecoratedBoxUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class PositionedUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   PositionedUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class PaddingUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   PaddingUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class FittedBoxUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   FittedBoxUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class ExpandedUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ExpandedUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class StackUIElement extends DuitElement implements MultiChildLayout {
//   @override
//   List<DuitElement> children = const [];

//   StackUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.children,
//   });
// }

// base class CustomUiElement extends DuitElement {
//   final Iterable<ElementTreeEntry> subviews;

//   CustomUiElement({
//     required super.id,
//     required super.controlled,
//     required UIElementController? viewController,
//     required ViewAttribute? attributes,
//     required super.tag,
//     this.subviews = const {},
//   }) : super(
//           type: ElementType.custom,
//           viewController: viewController,
//           attributes: attributes,
//         );
// }

// final class ElevatedButtonUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ElevatedButtonUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class CenterUIElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   CenterUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class ColoredBoxUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ColoredBoxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });
// //</editor-fold>
// }

// final class AnimatedBuilderUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   AnimatedBuilderUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });
// //</editor-fold>
// }

// final class ColumnUIElement extends DuitElement implements MultiChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   List<DuitElement> children = const [];

//   ColumnUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.children,
//   });
// //</editor-fold>
// }

// final class RowUIElement extends DuitElement implements MultiChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   List<DuitElement> children;

//   RowUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     this.children = const [],
//   });
// //</editor-fold>
// }

// final class WrapUIElement extends DuitElement implements MultiChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   List<DuitElement> children = const [];

//   WrapUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.children,
//   });
// //</editor-fold>
// }

// final class SizedBoxUIElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   SizedBoxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });
// //</editor-fold>
// }

// final class RepaintBoundaryUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   RepaintBoundaryUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });
// //</editor-fold>
// }

// final class RichTextUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   RichTextUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//   });

//   @override
//   String toString() {
//     return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
//   }
// //</editor-fold>
// }

// final class TextUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   TextUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//   });

//   @override
//   String toString() {
//     return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
//   }
// //</editor-fold>
// }

// final class CheckboxUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   CheckboxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//   });
// //</editor-fold>
// }

// final class RadioUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   RadioUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//   });
// //</editor-fold>
// }

// final class SliderUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   SliderUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//   });
// //</editor-fold>
// }

// final class TextFieldUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">
//   TextFieldUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//   });
// //</editor-fold>
// }

// final class ComponentUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ComponentUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class OverflowBoxUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   OverflowBoxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class AnimatedSizeUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   AnimatedSizeUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class AnimatedOpacityUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   AnimatedOpacityUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class SubtreeUIElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   SubtreeUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class ListViewUIElement extends DuitElement implements MultiChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   List<DuitElement> children;

//   ListViewUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.children,
//   });

// //</editor-fold>
// }

// final class GridViewUIElement extends DuitElement implements MultiChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   List<DuitElement> children;

//   GridViewUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.children,
//   });

// //</editor-fold>
// }

// final class ImageUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   ImageUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//   });
// //</editor-fold>
// }

// final class SwitchUiElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   SwitchUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//   });

//   @override
//   String toString() {
//     return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
//   }
// //</editor-fold>
// }

// final class IntrinsicHeightUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   IntrinsicHeightUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class IntrinsicWidthUiElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   IntrinsicWidthUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class RotatedBoxUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   RotatedBoxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class ConstrainedBoxUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   ConstrainedBoxUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class BackdropFilterUIElement extends DuitElement
//     implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   BackdropFilterUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class SafeAreaUiElement extends DuitElement implements SingleChildLayout {
//   //<editor-fold desc="Properties and ctor">
//   @override
//   DuitElement child;

//   SafeAreaUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });

// //</editor-fold>
// }

// final class EmptyUIElement extends DuitElement {
//   EmptyUIElement({
//     super.type = ElementType.empty,
//     super.id = "",
//   });
// }

// final class RemoteUIElement extends DuitElement {
//   //<editor-fold desc="Properties and ctor">

//   RemoteUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     super.viewController,
//     super.attributes,
//   });
// //</editor-fold>
// }

// /// A UI element that represents a Card widget.
// final class CardUIElement extends DuitElement implements SingleChildLayout {
//   @override
//   DuitElement child;

//   CardUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AppBarUiElement extends DuitElement {
//   AppBarUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//   });
// }

// final class ScaffoldUiElement extends DuitElement implements SingleChildLayout {
//   @override
//   DuitElement child;

//   ScaffoldUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required this.child,
//   });
// }

// final class InkWellUIElement extends DuitElement implements SingleChildLayout {
//   @override
//   DuitElement child;

//   InkWellUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class CarouselViewUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   CarouselViewUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.attributes,
//     required super.viewController,
//     required this.children,
//   });
// }

// final class AnimatedContainerUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedContainerUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AnimatedAlignUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedAlignUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AnimatedRotationUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedRotationUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AnimatedPaddingUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedPaddingUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AnimatedPositionedUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedPositionedUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AnimatedScaleUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedScaleUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class AbsorbPointerUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AbsorbPointerUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//     required super.attributes,
//   });
// }

// final class OffstageUIElement extends DuitElement implements SingleChildLayout {
//   @override
//   DuitElement child;

//   OffstageUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });
// }

// final class AnimatedCrossFadeUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   AnimatedCrossFadeUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.children,
//   });
// }

// final class AnimatedSlideUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedSlideUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class PhysicalModelUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   PhysicalModelUIElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//     required this.child,
//   });
// }

// final class AnimatedPhysicalModelUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   AnimatedPhysicalModelUIElement({
//     required super.type,
//     required super.id,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverPaddingUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverPaddingUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class CustomScrollViewUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   CustomScrollViewUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.children,
//   });
// }

// final class SliverFillRemainingUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverFillRemainingUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverToBoxAdapterUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverToBoxAdapterUIElement({
//     required super.type,
//     required super.id,
//     required this.child,
//   });
// }

// final class SliverFillViewportUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   SliverFillViewportUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.children,
//   });
// }

// final class SliverOpacityUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverOpacityUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverAnimatedOpacityUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverAnimatedOpacityUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverVisibilityUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverVisibilityUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverSafeAreaUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverSafeAreaUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverOffstageUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverOffstageUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverIgnorePointerUIElement extends DuitElement
//     implements SingleChildLayout {
//   @override
//   DuitElement child;

//   SliverIgnorePointerUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.child,
//   });
// }

// final class SliverListUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   SliverListUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.children,
//   });
// }

// final class FlexibleSpaceBarUiElement extends DuitElement {
//   FlexibleSpaceBarUiElement({
//     required super.type,
//     required super.id,
//     required super.controlled,
//     required super.viewController,
//     required super.attributes,
//   });
// }

// final class SliverAppBarUiElement extends DuitElement {
//   SliverAppBarUiElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//   });
// }

// final class SliverGridUIElement extends DuitElement
//     implements MultiChildLayout {
//   @override
//   List<DuitElement> children;

//   SliverGridUIElement({
//     required super.type,
//     required super.id,
//     required super.attributes,
//     required super.viewController,
//     required super.controlled,
//     required this.children,
//   });
// }
