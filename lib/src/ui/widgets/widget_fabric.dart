import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';

import 'index.dart';

mixin WidgetFabric {
  Widget getWidgetFromElement(DuitElement model) {
    switch (model.type) {
      case ElementType.column:
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
      case ElementType.row:
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
      case ElementType.coloredBox:
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
      case ElementType.center:
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
      case ElementType.sizedBox:
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
      case ElementType.text:
        final it = model as TextUIElement;

        return it.controlled
            ? DuitControlledText(
                controller: it.viewController,
              )
            : DuitText(attributes: it.attributes);
      case ElementType.richText:
        final it = model as RichTextUIElement;

        return it.controlled
            ? DuitControlledRichText(
                controller: it.viewController,
              )
            : DuitRichText(attributes: it.attributes);
      case ElementType.textField:
        final it = model as TextFieldUIElement;

        return DuitTextField(
          controller: it.viewController,
        );
      case ElementType.elevatedButton:
        final it = model as ElevatedButtonUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitElevatedButton(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.stack:
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
      case ElementType.wrap:
        final it = model as WrapUIElement;
        List<Widget> arr = [];

        for (var element in it.children) {
          final children = getWidgetFromElement(element);
          arr.add(children);
        }

        return it.controlled
            ? DuitControlledWrap(
                controller: it.viewController!,
                children: arr,
              )
            : DuitWrap(
                attributes: it.attributes!,
                children: arr,
              );
      case ElementType.expanded:
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
      case ElementType.positioned:
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
      case ElementType.padding:
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
      case ElementType.decoratedBox:
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
      case ElementType.checkbox:
        return DuitCheckbox(
          controller: model.viewController,
        );
      case ElementType.container:
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
      case ElementType.gestureDetector:
        final it = model as GestureDetectorUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitGestureDetector(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.align:
        final it = model as AlignUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledAlign(
                controller: it.viewController!,
                child: child,
              )
            : DuitAlign(
                attributes: it.attributes,
                child: child,
              );
      case ElementType.transform:
        final it = model as TransformUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledTransform(
                controller: it.viewController!,
                child: child,
              )
            : DuitTransform(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.image:
        final it = model as ImageUIElement;

        return it.controlled
            ? DuitControlledImage(
                controller: it.viewController!,
              )
            : DuitImage(
                attributes: it.attributes,
              );
      case ElementType.lifecycleStateListener:
        final it = model as LifecycleStateListenerUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitLifecycleStateListener(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.empty:
        return const DuitEmptyView();
      case ElementType.custom:
        if (model.tag != null) {
          final renderer = DuitRegistry.getRenderer(model.tag!);
          return renderer?.call(model) ?? const DuitEmptyView();
        }

        return const DuitEmptyView();
      default:
        return const SizedBox.shrink();
    }
  }
}
