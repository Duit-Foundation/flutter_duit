import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/models/element_models.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import 'package:flutter_duit/src/animations/animation_builder.dart';
import 'package:flutter_duit/src/ui/widgets/grid_constructor.dart';

import 'index.dart';

/// A mixin that provides a method to convert a [DuitElement] into a [Widget].
///
/// This mixin contains a static map that maps element types to their corresponding
/// widget constructors. It provides a method [getWidgetFromElement] that takes a
/// [DuitElement] and returns the corresponding [Widget].
///
/// Example usage:
/// ```dart
/// final widget = getWidgetFromElement(element);
/// ```
///
/// The [getWidgetFromElement] method uses the static map to determine the
/// appropriate widget constructor based on the element type.
mixin WidgetFabric {
  static const mp = <String, dynamic>{};

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
                controller: it.viewController!,
                children: arr,
              )
            : DuitColumn(
                attributes: it.attributes!,
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
                controller: it.viewController!,
                children: arr,
              )
            : DuitRow(
                attributes: it.attributes!,
                children: arr,
              );
      case ElementType.coloredBox:
        final it = model as ColoredBoxUIElement;

        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledColoredBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitColoredBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.animatedSize:
        final it = model as AnimatedSizeUIElement;

        final child = getWidgetFromElement(it.child);

        return DuitAnimatedSize(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedBuilder:
        final it = model as AnimatedBuilderUIElement;

        final child = getWidgetFromElement(it.child);

        return DuitAnimatedBuilder(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.center:
        final it = model as CenterUIElement;

        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledCenter(
                controller: it.viewController!,
                child: child,
              )
            : DuitCenter(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sizedBox:
        final it = model as SizedBoxUIElement;

        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSizedBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitSizedBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.text:
        final it = model as TextUIElement;

        return it.controlled
            ? DuitControlledText(
                controller: it.viewController!,
              )
            : DuitText(
                attributes: it.attributes!,
              );
      case ElementType.richText:
        final it = model as RichTextUIElement;

        return it.controlled
            ? DuitControlledRichText(
                controller: it.viewController!,
              )
            : DuitRichText(
                attributes: it.attributes!,
              );
      case ElementType.textField:
        final it = model as TextFieldUIElement;

        return DuitTextField(
          controller: it.viewController!,
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
                controller: it.viewController!,
                children: arr,
              )
            : DuitStack(
                attributes: it.attributes!,
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
                attributes: it.attributes!,
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
                attributes: it.attributes!,
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
                attributes: it.attributes!,
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
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.checkbox:
        final it = model as CheckboxUIElement;

        return DuitCheckbox(
          controller: it.viewController!,
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
                attributes: it.attributes!,
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
                attributes: it.attributes!,
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
                attributes: it.attributes!,
              );
      case ElementType.radio:
        final it = model as RadioUIElement;

        return it.controlled
            ? DuitControlledRadio(
                controller: it.viewController!,
              )
            : DuitRadio(
                attributes: it.attributes!,
              );
      case ElementType.switchW:
        final it = model as SwitchUiElement;

        return DuitSwitch(
          controller: it.viewController!,
        );
      case ElementType.radioGroupContext:
        final it = model as RadioGroupContextUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitRadioGroupContextProvider(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.slider:
        final it = model as SliderUIElement;

        return DuitSlider(
          controller: it.viewController!,
        );
      case ElementType.fittedBox:
        final it = model as FittedBoxUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledFittedBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitFittedBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.lifecycleStateListener:
        final it = model as LifecycleStateListenerUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitLifecycleStateListener(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.singleChildScrollview:
        final it = model as SingleChildScrollviewUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSingleChildScrollView(
                controller: it.viewController!,
                child: child,
              )
            : DuitSingleChildScrollView(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.ignorePointer:
        final it = model as IgnorePointerUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledIgnorePointer(
                controller: it.viewController!,
                child: child,
              )
            : DuitIgnorePointer(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.opacity:
        final it = model as OpacityUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledOpacity(
                controller: it.viewController!,
                child: child,
              )
            : DuitOpacity(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.component:
        final it = model as ComponentUIElement;
        final child = getWidgetFromElement(it.child);
        return DuitComponent(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.repaintBoundary:
        final it = model as RepaintBoundaryUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledRepaintBoundary(
                controller: it.viewController!,
                child: child,
              )
            : DuitRepaintBoundary(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.overflowBox:
        final it = model as OverflowBoxUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledOverflowBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitOverflowBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.subtree:
        final it = model as SubtreeUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitSubtree(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.listView:
        final it = model as ListViewUIElement;

        int widgetType;

        if (!it.controlled) {
          widgetType = it.attributes!.payload.getInt(key: "type");
        } else {
          widgetType =
              it.viewController!.attributes.payload.getInt(key: "type");
        }

        switch (widgetType) {
          case 0:
            List<Widget> arr = [];

            for (var element in it.children) {
              final children = getWidgetFromElement(element);
              arr.add(children);
            }

            return it.controlled
                ? DuitControlledListView(
                    controller: it.viewController!,
                    children: arr,
                  )
                : DuitListView(
                    attributes: it.attributes!,
                    children: arr,
                  );
          case 1:
            return DuitListViewBuilder(
              controller: it.viewController!,
            );
          case 2:
            return DuitListViewSeparated(
              controller: it.viewController!,
            );
          default:
            return const SizedBox.shrink();
        }
      case ElementType.gridView:
        final it = model as GridViewUIElement;

        GridConstructor widgetType;

        if (!it.controlled) {
          widgetType = GridConstructor.fromValue(
            it.attributes!.payload.getString(key: "constructor"),
          );
        } else {
          widgetType = GridConstructor.fromValue(
            it.viewController!.attributes.payload.getString(key: "constructor"),
          );
        }

        switch (widgetType) {
          case GridConstructor.common:
          case GridConstructor.count:
          case GridConstructor.extent:
            final arr = <Widget>[];

            for (var element in it.children) {
              final children = getWidgetFromElement(element);
              arr.add(children);
            }

            if (!it.controlled) {
              return DuitGridView(
                constructor: widgetType,
                attributes: it.attributes!,
                children: arr,
              );
            } else {
              return DuitControlledGridView(
                constructor: widgetType,
                controller: it.viewController!,
                children: arr,
              );
            }
          case GridConstructor.builder:
            return DuitGridBuilder(
              controller: it.viewController!,
            );
        }

      case ElementType.meta:
        final it = model as MetaUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitMetaWidget(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.intrinsicHeight:
        final it = model as IntrinsicHeightUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledIntrinsicHeight(
                controller: it.viewController!,
                child: child,
              )
            : DuitIntrinsicHeight(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.intrinsicWidth:
        final it = model as IntrinsicWidthUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledIntrinsicWidth(
                controller: it.viewController!,
                child: child,
              )
            : DuitIntrinsicWidth(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.rotatedBox:
        final it = model as RotatedBoxUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledRotatedBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitRotatedBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.constrainedBox:
        final it = model as ConstrainedBoxUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledConstrainedBox(
                controller: it.viewController!,
                child: child,
              )
            : DuitConstrainedBox(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.backdropFilter:
        final it = model as BackdropFilterUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledBackdropFilter(
                controller: it.viewController!,
                child: child,
              )
            : DuitBackdropFilter(
                attributes: it.attributes!,
                child: child,
              );

      case ElementType.animatedOpacity:
        final it = model as AnimatedOpacityUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedOpacity(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.remoteSubtree:
        final it = model as RemoteUIElement;

        return DuitRemoteSubtree(
          controller: it.viewController!,
        );
      case ElementType.safeArea:
        final it = model as SafeAreaUiElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSafeArea(
                controller: it.viewController!,
                child: child,
              )
            : DuitSafeArea(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.empty:
        return const DuitEmptyView();
      case ElementType.appBar:
        final it = model as AppBarUiElement;

        return DuitAppBar(
          controller: it.viewController!,
        );
      case ElementType.scaffold:
        final it = model as ScaffoldUiElement;
        final child = getWidgetFromElement(it.child);

        return DuitScaffold(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.inkWell:
        final it = model as InkWellUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitInkWell(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.custom:
        final customWidgetModel = model as CustomUiElement;
        if (customWidgetModel.tag != null) {
          final children = <Widget>{};

          for (var subview in customWidgetModel.subviews) {
            final child = getWidgetFromElement(subview as DuitElement);
            children.add(child);
          }

          final renderer = DuitRegistry.getBuildFactory(customWidgetModel.tag!);
          return renderer?.call(customWidgetModel, children) ??
              const DuitEmptyView();
        }

        return const DuitEmptyView();
      case ElementType.card:
        final it = model as CardUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledCard(
                controller: it.viewController!,
                child: child,
              )
            : DuitCard(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.carouselView:
        final it = model as CarouselViewUIElement;
        List<Widget> arr = [];

        for (var element in it.children) {
          final children = getWidgetFromElement(element);
          arr.add(children);
        }

        return it.controlled
            ? DuitControlledCarouselView(
                controller: it.viewController!,
                children: arr,
              )
            : DuitCarouselView(
                attributes: it.attributes!,
                children: arr,
              );
      case ElementType.animatedAlign:
        final it = model as AnimatedAlignUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedAlign(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedRotation:
        final it = model as AnimatedRotationUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedRotation(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedPadding:
        final it = model as AnimatedPaddingUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedPadding(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedContainer:
        final it = model as AnimatedContainerUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedContainer(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedPositioned:
        final it = model as AnimatedPositionedUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedPositioned(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.animatedScale:
        final it = model as AnimatedScaleUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedScale(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.absorbPointer:
        final it = model as AbsorbPointerUIElement;
        final child = getWidgetFromElement(it.child);
        return it.controlled
            ? DuitControlledAbsorbPointer(
                controller: it.viewController!,
                child: child,
              )
            : DuitAbsorbPointer(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.offstage:
        final it = model as OffstageUIElement;
        final child = getWidgetFromElement(it.child);
        return it.controlled
            ? DuitControlledOffstage(
                controller: it.viewController!,
                child: child,
              )
            : DuitOffstage(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.animatedCrossFade:
        final it = model as AnimatedCrossFadeUIElement;
        List<Widget> arr = [];

        for (var element in it.children) {
          final children = getWidgetFromElement(element);
          arr.add(children);
        }

        return DuitAnimatedCrossFade(
          controller: it.viewController!,
          children: arr,
        );
      case ElementType.animatedSlide:
        final it = model as AnimatedSlideUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedSlide(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.physicalModel:
        final it = model as PhysicalModelUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledPhysicalModel(
                controller: it.viewController!,
                child: child,
              )
            : DuitPhysicalModel(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.animatedPhysicalModel:
        final it = model as AnimatedPhysicalModelUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitAnimatedPhysicalModel(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.sliverPadding:
        final it = model as SliverPaddingUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverPadding(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverPadding(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.customScrollView:
        final it = model as CustomScrollViewUIElement;

        final arr = <Widget>[];

        for (var element in it.children) {
          arr.add(getWidgetFromElement(element));
        }

        return it.controlled
            ? DuitControlledCustomScrollView(
                controller: it.viewController!,
                children: arr,
              )
            : DuitCustomScrollView(
                attributes: it.attributes!,
                children: arr,
              );
      case ElementType.sliverFillRemaining:
        final it = model as SliverFillRemainingUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverFillRemaining(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverFillRemaining(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverToBoxAdapter:
        final it = model as SliverToBoxAdapterUIElement;
        final child = getWidgetFromElement(it.child);

        return SliverToBoxAdapter(
          key: ValueKey(it.id),
          child: child,
        );
      case ElementType.sliverFillViewport:
        final it = model as SliverFillViewportUIElement;

        final arr = <Widget>[];

        for (var element in it.children) {
          arr.add(getWidgetFromElement(element));
        }

        return it.controlled
            ? DuitControlledSliverFillViewport(
                controller: it.viewController!,
                children: arr,
              )
            : DuitSliverFillViewport(
                attributes: it.attributes!,
                children: arr,
              );
      case ElementType.sliverVisibility:
        final it = model as SliverVisibilityUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverVisibility(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverVisibility(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverOffstage:
        final it = model as SliverOffstageUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverOffstage(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverOffstage(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverOpacity:
        final it = model as SliverOpacityUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverOpacity(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverOpacity(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverAnimatedOpacity:
        final it = model as SliverAnimatedOpacityUIElement;
        final child = getWidgetFromElement(it.child);

        return DuitSliverAnimatedOpacity(
          controller: it.viewController!,
          child: child,
        );
      case ElementType.sliverSafeArea:
        final it = model as SliverSafeAreaUIElement;
        final child = getWidgetFromElement(it.child);

        return it.controlled
            ? DuitControlledSliverSafeArea(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverSafeArea(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverIgnorePointer:
        final it = model as SliverIgnorePointerUIElement;
        final child = getWidgetFromElement(it.child);
        return it.controlled
            ? DuitControlledSliverIgnorePointer(
                controller: it.viewController!,
                child: child,
              )
            : DuitSliverIgnorePointer(
                attributes: it.attributes!,
                child: child,
              );
      case ElementType.sliverList:
        final it = model as SliverListUIElement;

        int widgetType;

        if (!it.controlled) {
          widgetType = it.attributes!.payload.getInt(key: "type");
        } else {
          widgetType =
              it.viewController!.attributes.payload.getInt(key: "type");
        }

        switch (widgetType) {
          case 0:
            List<Widget> arr = [];

            for (var element in it.children) {
              final children = getWidgetFromElement(element);
              arr.add(children);
            }

            return it.controlled
                ? DuitControlledSliverList(
                    controller: it.viewController!,
                    children: arr,
                  )
                : DuitSliverList(
                    attributes: it.attributes!,
                    children: arr,
                  );
          case 1:
            return DuitSliverListBuilder(
              controller: it.viewController!,
            );
          case 2:
            return DuitSliverListSeparated(
              controller: it.viewController!,
            );
          default:
            return const SizedBox.shrink();
        }
      case ElementType.sliverAppBar:
        final it = model as SliverAppBarUiElement;
        return DuitSliverAppBar(
          controller: it.viewController!,
        );
      case ElementType.flexibleSpaceBar:
        final it = model as FlexibleSpaceBarUiElement;
        return DuitFlexibleSpaceBar(
          controller: it.viewController!,
        );
      case ElementType.sliverGrid:
        final it = model as SliverGridUIElement;

        GridConstructor widgetType;

        if (!it.controlled) {
          widgetType = GridConstructor.fromValue(
            it.attributes!.payload.getString(key: "constructor"),
          );
        } else {
          widgetType = GridConstructor.fromValue(
            it.viewController!.attributes.payload.getString(key: "constructor"),
          );
        }

        switch (widgetType) {
          case GridConstructor.common:
          case GridConstructor.count:
          case GridConstructor.extent:
            final arr = <Widget>[];

            for (var element in it.children) {
              final children = getWidgetFromElement(element);
              arr.add(children);
            }

            if (!it.controlled) {
              return DuitSliverGrid(
                constructor: widgetType,
                attributes: it.attributes!,
                children: arr,
              );
            } else {
              return DuitControlledSliverGrid(
                constructor: widgetType,
                controller: it.viewController!,
                children: arr,
              );
            }
          case GridConstructor.builder:
            return DuitSliverGridBuilder(
              controller: it.viewController!,
            );
        }
      default:
        return const SizedBox.shrink();
    }
  }
}
