import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import "package:flutter_duit/src/ui/models/child.dart";

final class MetaUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  MetaUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class SingleChildScrollviewUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SingleChildScrollviewUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class IgnorePointerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  IgnorePointerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class OpacityUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  OpacityUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class LifecycleStateListenerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  LifecycleStateListenerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class RadioGroupContextUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  RadioGroupContextUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class TransformUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  TransformUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class AlignUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AlignUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class GestureDetectorUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  GestureDetectorUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ContainerUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ContainerUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class DecoratedBoxUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  DecoratedBoxUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PositionedUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  PositionedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class PaddingUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  PaddingUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class FittedBoxUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  FittedBoxUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ExpandedUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ExpandedUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class StackUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  @override
  List<DuitElement> children = const [];

  StackUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
}

base class CustomUiElement<T> extends DuitElement<T> {
  final Iterable<ElementTreeEntry> subviews;

  CustomUiElement({
    required super.id,
    required super.controlled,
    required UIElementController? viewController,
    required ViewAttribute? attributes,
    required super.tag,
    this.subviews = const {},
  }) : super(
          type: ElementType.custom,
          viewController: viewController?.cast<T>(),
          attributes: attributes?.cast<T>(),
        );
}

final class ElevatedButtonUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ElevatedButtonUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class CenterUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  CenterUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class ColoredBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ColoredBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });
//</editor-fold>
}

final class AnimatedBuilderUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AnimatedBuilderUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });
//</editor-fold>
}

final class ColumnUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children = const [];

  ColumnUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
//</editor-fold>
}

final class RowUIElement<T> extends DuitElement<T> implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children;

  RowUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    this.children = const [],
  });
//</editor-fold>
}

final class WrapUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children = const [];

  WrapUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.children,
  });
//</editor-fold>
}

final class SizedBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SizedBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });
//</editor-fold>
}

final class RepaintBoundaryUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  RepaintBoundaryUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });
//</editor-fold>
}

final class RichTextUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  RichTextUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class TextUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  TextUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class CheckboxUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  CheckboxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class RadioUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  RadioUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class SliderUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  SliderUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class TextFieldUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">
  TextFieldUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class ComponentUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ComponentUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class OverflowBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  OverflowBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class AnimatedSizeUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AnimatedSizeUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class AnimatedOpacityUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AnimatedOpacityUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class SubtreeUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SubtreeUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class ListViewUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children;

  ListViewUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.children,
  });

//</editor-fold>
}

final class GridViewUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  List<DuitElement> children;

  GridViewUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.children,
  });

//</editor-fold>
}

final class ImageUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  ImageUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
  });
//</editor-fold>
}

final class SwitchUiElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  SwitchUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
  });

  @override
  String toString() {
    return 'TextUIElement{attributes: $attributes, viewController: $viewController, uncontrolled: $controlled}';
  }
//</editor-fold>
}

final class IntrinsicHeightUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  IntrinsicHeightUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class IntrinsicWidthUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  IntrinsicWidthUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class RotatedBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  RotatedBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class ConstrainedBoxUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  ConstrainedBoxUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class BackdropFilterUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  BackdropFilterUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class SafeAreaUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  SafeAreaUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });

//</editor-fold>
}

final class EmptyUIElement<T> extends DuitElement<T> {
  EmptyUIElement({
    super.type = ElementType.empty,
    super.id = "",
  });
}

final class RemoteUIElement<T> extends DuitElement<T> {
  //<editor-fold desc="Properties and ctor">

  RemoteUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    super.viewController,
    super.attributes,
  });
//</editor-fold>
}

/// A UI element that represents a Card widget.
final class CardUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  CardUIElement({
    required super.type,
    required super.id,
    required super.attributes,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AppBarUiElement<T> extends DuitElement<T> {
  AppBarUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
  });
}

final class ScaffoldUiElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  ScaffoldUiElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required this.child,
  });
}

final class InkWellUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  InkWellUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class CarouselViewUIElement<T> extends DuitElement<T>
    implements MultiChildLayout {
  @override
  List<DuitElement> children;

  CarouselViewUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.children,
  });
}

final class AnimatedContainerUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedContainerUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AnimatedAlignUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedAlignUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AnimatedRotationUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedRotationUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AnimatedPaddingUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedPaddingUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AnimatedPositionedUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedPositionedUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AnimatedScaleUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  AnimatedScaleUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
  });
}

final class AbsorbPointerUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;
  
   AbsorbPointerUIElement({
    required super.type,
    required super.id,
    required super.viewController,
    required super.controlled,
    required this.child,
    required super.attributes,
  });
}

final class OffstageUIElement<T> extends DuitElement<T>
    implements SingleChildLayout {
  @override
  DuitElement child;

  OffstageUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.viewController,
    required super.attributes,
    required this.child,
  });
}
