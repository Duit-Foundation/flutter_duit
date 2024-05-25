import 'package:duit_kernel/duit_kernel.dart';

import 'child.dart';
import 'element.dart';
import 'element_type.dart';

final class MetaUiElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class SingleChildScrollviewUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class IgnorePointerUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class OpacityUiElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class LifecycleStateListenerUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class RadioGroupContextUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class TransformUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class AlignUiElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class GestureDetectorUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class ContainerUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class DecoratedBoxUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class PositionedUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class PaddingUiElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class FittedBoxUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class ExpandedUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class StackUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class CustomDUITElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
  CustomDUITElement({
    required super.id,
  }) : super(type: ElementType.custom);
}

final class ElevatedButtonUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class CenterUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class ColoredBoxUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class ColumnUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class RowUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
    implements MultiChildLayout {
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

final class WrapUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class SizedBoxUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class RepaintBoundaryUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class RichTextUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
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

final class TextUIElement<T extends DuitAttributes<T>> extends DuitElement<T> {
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

final class CheckboxUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
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

final class RadioUIElement<T extends DuitAttributes<T>> extends DuitElement<T> {
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

final class SliderUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
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

final class TextFieldUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
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

final class ComponentUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class OverflowBoxUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
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

final class SubtreeUIElement<T extends DuitAttributes<T>> extends DuitElement<T>
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

final class ListViewUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements MultiChildLayout {
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

final class ImageUIElement<T extends DuitAttributes<T>> extends DuitElement<T> {
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

final class SwitchUiElement<T extends DuitAttributes<T>>
    extends DuitElement<T> {
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

final class AnimatedSizeUIElement<T extends DuitAttributes<T>>
    extends DuitElement<T> implements SingleChildLayout {
  //<editor-fold desc="Properties and ctor">
  @override
  DuitElement child;

  AnimatedSizeUIElement({
    required super.type,
    required super.id,
    required super.controlled,
    required super.attributes,
    required super.viewController,
    required this.child,
  });

//</editor-fold>
}

final class EmptyUIElement<T extends DuitAttributes<T>> extends DuitElement<T> {
  EmptyUIElement({
    super.type = ElementType.empty,
    super.id = "",
  });
}
