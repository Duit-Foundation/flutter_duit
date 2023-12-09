import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_impl/registry.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/widgets/positioned.dart';

import 'index.dart';

mixin WidgetFabric {
  Widget getWidgetFromElement(DUITElement model) {
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
              ? DUITControlledColumn(
                  controller: it.viewController,
                  children: arr,
                )
              : DUITColumn(
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
              ? DUITControlledRow(
                  controller: it.viewController,
                  children: arr,
                )
              : DUITRow(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.coloredBox:
        {
          final it = model as ColoredBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledColoredBox(
                  controller: it.viewController,
                  child: child,
                )
              : DUITColoredBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.center:
        {
          final it = model as CenterUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledCenter(
                  controller: it.viewController,
                  child: child,
                )
              : DUITCenter(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.sizedBox:
        {
          final it = model as SizedBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledSizedBox(
                  controller: it.viewController,
                  child: child,
                )
              : DUITSizedBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.text:
        {
          final it = model as TextUIElement;

          return it.controlled
              ? DUITControlledText(
                  controller: it.viewController,
                )
              : DUITText(attributes: it.attributes);
        }
      case DUITElementType.textField:
        {
          final it = model as TextFieldUIElement;

          return DUITTextField(
            controller: it.viewController,
          );
        }
      case DUITElementType.elevatedButton:
        {
          final it = model as ElevatedButtonUIElement;
          final child = getWidgetFromElement(it.child);

          return DUITControlledButton(
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
              ? DUITControlledStack(
                  controller: it.viewController,
                  children: arr,
                )
              : DUITStack(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.expanded:
        {
          final it = model as ExpandedUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledExpanded(
                  controller: it.viewController!,
                  child: child,
                )
              : DUITExpanded(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.positioned:
        {
          final it = model as PositionedUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledPositioned(
                  controller: it.viewController!,
                  child: child,
                )
              : DUITPositioned(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.padding:
        {
          final it = model as PaddingUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledPadding(
                  controller: it.viewController!,
                  child: child,
                )
              : DUITPadding(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.decoratedBox:
        {
          final it = model as DecoratedBoxUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledDecoratedBox(
                  controller: it.viewController!,
                  child: child,
                )
              : DUITDecoratedBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.checkbox:
        {
          return DUITCheckbox(
            controller: model.viewController,
          );
        }
      case DUITElementType.container:
        {
          final it = model as ContainerUiElement;
          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledContainer(
                  controller: it.viewController!,
                  child: child,
                )
              : DUITContainer(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.image:
        {
          final it = model as ImageUIElement;

          return it.controlled
              ? DUITControlledImage(
                  controller: it.viewController!,
                )
              : DUITImage(
                  attributes: it.attributes,
                );
        }
      case DUITElementType.empty:
        {
          return const DUITEmptyView();
        }
      case DUITElementType.custom:
        {
          if (model.tag != null) {
            final renderer = DUITRegistry.getRenderer(model.tag!);
            return renderer?.call(model) ?? const DUITEmptyView();
          }

          return const DUITEmptyView();
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}
