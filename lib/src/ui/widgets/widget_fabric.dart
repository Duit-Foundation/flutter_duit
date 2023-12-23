import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_kernel/el_type.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/widgets/gesture_detector.dart';
import 'package:flutter_duit/src/ui/widgets/positioned.dart';

import 'index.dart';

mixin WidgetFabric {
  Widget getWidgetFromElement(DuitElement model) {
    switch (model.type) {
      case DUITElementType.column:
        {
          final it = model as ColumnUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          return it.controlled
              ? DuitControlledColumn(
                  controller: it.viewController,
                  children: arr,
                )
              : DuitColumn(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.row:
        {
          final it = model as RowUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          return it.controlled
              ? DuitControlledRow(
                  controller: it.viewController,
                  children: arr,
                )
              : DuitRow(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.coloredBox:
        {
          final it = model as ColoredBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledColoredBox(
                  controller: it.viewController,
                  child: child,
                )
              : DuitColoredBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.center:
        {
          final it = model as CenterUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledCenter(
                  controller: it.viewController,
                  child: child,
                )
              : DuitCenter(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.sizedBox:
        {
          final it = model as SizedBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledSizedBox(
                  controller: it.viewController,
                  child: child,
                )
              : DuitSizedBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.text:
        {
          final it = model as TextUIElement;

          return it.controlled
              ? DuitControlledText(
                  controller: it.viewController,
                )
              : DuitText(attributes: it.attributes);
        }
      case DUITElementType.textField:
        {
          final it = model as TextFieldUIElement;

          return DuitTextField(
            controller: it.viewController,
          );
        }
      case DUITElementType.elevatedButton:
        {
          final it = model as ElevatedButtonUIElement;
          final child = getWidgetFromElement(it.child);

          return DuitElevatedButton(
            controller: it.viewController!,
            child: child,
          );
        }
      case DUITElementType.stack:
        {
          final it = model as StackUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          return it.controlled
              ? DuitControlledStack(
                  controller: it.viewController,
                  children: arr,
                )
              : DuitStack(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.expanded:
        {
          final it = model as ExpandedUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledExpanded(
                  controller: it.viewController!,
                  child: child,
                )
              : DuitExpanded(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.positioned:
        {
          final it = model as PositionedUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledPositioned(
                  controller: it.viewController!,
                  child: child,
                )
              : DuitPositioned(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.padding:
        {
          final it = model as PaddingUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledPadding(
                  controller: it.viewController!,
                  child: child,
                )
              : DuitPadding(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.decoratedBox:
        {
          final it = model as DecoratedBoxUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledDecoratedBox(
                  controller: it.viewController!,
                  child: child,
                )
              : DuitDecoratedBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.checkbox:
        {
          return DuitCheckbox(
            controller: model.viewController,
          );
        }
      case DUITElementType.container:
        {
          final it = model as ContainerUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DuitControlledContainer(
                  controller: it.viewController!,
                  child: child,
                )
              : DuitContainer(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.gestureDetector:
        {
          final it = model as GestureDetectorUiElement;
          final child = getWidgetFromElement(it.child);

          return DuitGestureDetector(
            controller: it.viewController!,
            child: child,
          );
        }
      case DUITElementType.image:
        {
          final it = model as ImageUIElement;

          return it.controlled
              ? DuitControlledImage(
                  controller: it.viewController!,
                )
              : DuitImage(
                  attributes: it.attributes,
                );
        }
      case DUITElementType.empty:
        {
          return const DuitEmptyView();
        }
      case DUITElementType.custom:
        {
          if (model.tag != null) {
            final renderer = DuitRegistry.getRenderer(model.tag!);
            return renderer?.call(model) ?? const DuitEmptyView();
          }

          return const DuitEmptyView();
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}
