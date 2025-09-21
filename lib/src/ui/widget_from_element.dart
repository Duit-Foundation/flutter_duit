part of "element_property_view.dart";

List<Widget?> _mapToNullableWidgetList(ElementPropertyView model) =>
    model.children
        .map<Widget?>(
          (child) => child == null ? null : _buildWidget(child),
        )
        .toList();

Widget _buildText(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledText(controller: model.viewController),
    false => DuitText(attributes: model.attributes),
  };
}

Widget _buildRow(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledRow(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitRow(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildStack(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledStack(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitStack(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildElevatedButton(ElementPropertyView model) {
  return DuitElevatedButton(
    controller: model.viewController,
    child: _buildWidget(model.child),
  );
}

Widget _buildTextField(ElementPropertyView model) => DuitTextField(
      controller: model.viewController,
    );

Widget _buildSlider(ElementPropertyView model) => DuitSlider(
      controller: model.viewController,
    );

Widget _buildSwitch(ElementPropertyView model) => DuitSwitch(
      controller: model.viewController,
    );

Widget _buildRichText(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledRichText(
        controller: model.viewController,
      ),
    false => DuitRichText(
        attributes: model.attributes,
      ),
  };
}

Widget _buildCheckbox(ElementPropertyView model) => DuitCheckbox(
      controller: model.viewController,
    );

Widget _buildRadio(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledRadio(
        controller: model.viewController,
      ),
    false => DuitRadio(
        attributes: model.attributes,
      ),
  };
}

Widget _buildRadioGroupContext(ElementPropertyView model) {
  return DuitRadioGroupContextProvider(
    controller: model.viewController,
    child: _buildWidget(model.child),
  );
}

Widget _buildColumn(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledColumn(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitColumn(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildAbsorbPointer(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledAbsorbPointer(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitAbsorbPointer(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildOffstage(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledOffstage(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitOffstage(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildDecoratedBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledDecoratedBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitDecoratedBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildCenter(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledCenter(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitCenter(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildAlign(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledAlign(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitAlign(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildTransform(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledTransform(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitTransform(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildInkWell(ElementPropertyView model) => DuitInkWell(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAppBar(ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);

  return switch (model.controlled) {
    true => DuitControlledAppBar(
      controller: model.viewController,
        children: children,
      ),
    false => DuitAppBar(
        attributes: model.attributes,
        children: children,
      ),
  };
}

Widget _buildScaffold(ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);

  return switch (model.controlled) {
    true => DuitControlledScaffold(
        controller: model.viewController,
        children: children,
      ),
    false => DuitScaffold(
        attributes: model.attributes,
        children: children,
      ),
  };
}

Widget _buildPositioned(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledPositioned(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitPositioned(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSubtree(ElementPropertyView model) => DuitSubtree(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildMeta(ElementPropertyView model) => DuitMetaWidget(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildContainer(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledContainer(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitContainer(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSizedBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSizedBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSizedBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildPadding(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledPadding(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitPadding(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSingleChildScrollView(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSingleChildScrollView(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSingleChildScrollView(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildAnimatedBuilder(ElementPropertyView model) => DuitAnimatedBuilder(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildRepaintBoundary(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledRepaintBoundary(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitRepaintBoundary(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildOverflowBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledOverflowBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitOverflowBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

// Image widget
Widget _buildImage(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledImage(
        controller: model.viewController,
      ),
    false => DuitImage(
        attributes: model.attributes,
      ),
  };
}

// Animated widgets - all controlled only
Widget _buildAnimatedSize(ElementPropertyView model) => DuitAnimatedSize(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedOpacity(ElementPropertyView model) => DuitAnimatedOpacity(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedContainer(ElementPropertyView model) =>
    DuitAnimatedContainer(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedAlign(ElementPropertyView model) => DuitAnimatedAlign(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedRotation(ElementPropertyView model) =>
    DuitAnimatedRotation(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedPadding(ElementPropertyView model) => DuitAnimatedPadding(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedPositioned(ElementPropertyView model) =>
    DuitAnimatedPositioned(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedScale(ElementPropertyView model) => DuitAnimatedScale(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedCrossFade(ElementPropertyView model) =>
    DuitAnimatedCrossFade(
      controller: model.viewController,
      children: model.children.map(_buildWidget).toList(),
    );

Widget _buildAnimatedPhysicalModel(ElementPropertyView model) =>
    DuitAnimatedPhysicalModel(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildAnimatedSlide(ElementPropertyView model) => DuitAnimatedSlide(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

// Single child widgets with controlled/non-controlled versions
Widget _buildIntrinsicHeight(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledIntrinsicHeight(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitIntrinsicHeight(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildIntrinsicWidth(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledIntrinsicWidth(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitIntrinsicWidth(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildRotatedBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledRotatedBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitRotatedBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildConstrainedBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledConstrainedBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitConstrainedBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildBackdropFilter(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledBackdropFilter(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitBackdropFilter(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildRemoteSubtree(ElementPropertyView model) => DuitRemoteSubtree(
      controller: model.viewController,
    );

Widget _buildSafeArea(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSafeArea(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSafeArea(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildCard(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledCard(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitCard(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildExpanded(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledExpanded(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitExpanded(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildGestureDetector(ElementPropertyView model) => DuitGestureDetector(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildColoredBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledColoredBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitColoredBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildLifecycleStateListener(ElementPropertyView model) =>
    DuitLifecycleStateListener(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildIgnorePointer(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledIgnorePointer(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitIgnorePointer(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildOpacity(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledOpacity(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitOpacity(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildFittedBox(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledFittedBox(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitFittedBox(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildPhysicalModel(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledPhysicalModel(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitPhysicalModel(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildFlexibleSpaceBar(ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);

  return switch (model.controlled) {
    true => DuitControlledFlexibleSpaceBar(
        controller: model.viewController,
        children: children,
      ),
    false => DuitFlexibleSpaceBar(
        attributes: model.attributes,
        children: children,
      ),
  };
}

Widget _buildSliverPadding(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverPadding(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverPadding(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildCustomScrollView(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledCustomScrollView(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitCustomScrollView(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildSliverFillRemaining(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverFillRemaining(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverFillRemaining(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

// SliverToBoxAdapter is not a standalone widget - it's used internally by other slivers
Widget _buildSliverToBoxAdapter(ElementPropertyView model) =>
    SliverToBoxAdapter(
      child: _buildWidget(model.child),
    );

Widget _buildSliverFillViewport(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverFillViewport(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitSliverFillViewport(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildSliverOpacity(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverOpacity(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverOpacity(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSliverVisibility(ElementPropertyView model) {
  final arr = model.children;
  // SliverVisibility widget expects two children: sliver and replacementSliver
  // This is necessary because the replacementSliver parameter requires a non-nullable widget
  final children = List<Widget>.generate(2, (index) {
    final child = arr.elementAtOrNull(index);
    return child == null ? const SliverToBoxAdapter() : _buildWidget(child);
  });

  return switch (model.controlled) {
    true => DuitControlledSliverVisibility(
        controller: model.viewController,
        children: children,
      ),
    false => DuitSliverVisibility(
        attributes: model.attributes,
        children: children,
      ),
  };
}

Widget _buildSliverAnimatedOpacity(ElementPropertyView model) =>
    DuitSliverAnimatedOpacity(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildSliverOffstage(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverOffstage(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverOffstage(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSliverIgnorePointer(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverIgnorePointer(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverIgnorePointer(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSliverSafeArea(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledSliverSafeArea(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitSliverSafeArea(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}

Widget _buildSliverAppBar(ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);

  return switch (model.controlled) {
    true => DuitControlledSliverAppBar(
        controller: model.viewController,
        children: children,
      ),
    false => DuitSliverAppBar(
        attributes: model.attributes,
        children: children,
      ),
  };
}

Widget _buildComponent(ElementPropertyView model) => DuitComponent(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

Widget _buildListView(ElementPropertyView model) {
  int widgetType;

  if (!model.controlled) {
    widgetType = model.attributes.payload.getInt(key: "type");
  } else {
    widgetType = model.viewController.attributes.payload.getInt(key: "type");
  }

  switch (widgetType) {
    case 0:
      return model.controlled
          ? DuitControlledListView(
              controller: model.viewController,
              children: model.children.map(_buildWidget).toList(),
            )
          : DuitListView(
              attributes: model.attributes,
              children: model.children.map(_buildWidget).toList(),
            );
    case 1:
      return DuitListViewBuilder(
        controller: model.viewController,
      );
    case 2:
      return DuitListViewSeparated(
        controller: model.viewController,
      );
    default:
      return const SizedBox.shrink();
  }
}

Widget _buildGridView(ElementPropertyView model) {
  GridConstructor widgetType;

  if (!model.controlled) {
    widgetType = GridConstructor.fromValue(
      model.attributes.payload.getString(key: "constructor"),
    );
  } else {
    widgetType = GridConstructor.fromValue(
      model.viewController.attributes.payload.getString(key: "constructor"),
    );
  }

  switch (widgetType) {
    case GridConstructor.common:
    case GridConstructor.count:
    case GridConstructor.extent:
      if (!model.controlled) {
        return DuitGridView(
          constructor: widgetType,
          attributes: model.attributes,
          children: model.children.map(_buildWidget).toList(),
        );
      } else {
        return DuitControlledGridView(
          constructor: widgetType,
          controller: model.viewController,
          children: model.children.map(_buildWidget).toList(),
        );
      }
    case GridConstructor.builder:
      return DuitGridBuilder(
        controller: model.viewController,
      );
  }
}

Widget _buildCarouselView(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledCarouselView(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitCarouselView(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildSliverList(ElementPropertyView model) {
  int widgetType;

  if (!model.controlled) {
    widgetType = model.attributes.payload.getInt(key: "type");
  } else {
    widgetType = model.viewController.attributes.payload.getInt(key: "type");
  }

  switch (widgetType) {
    case 0:
      return model.controlled
          ? DuitControlledSliverList(
              controller: model.viewController,
              children: model.children.map(_buildWidget).toList(),
            )
          : DuitSliverList(
              attributes: model.attributes,
              children: model.children.map(_buildWidget).toList(),
            );
    case 1:
      return DuitSliverListBuilder(
        controller: model.viewController,
      );
    case 2:
      return DuitSliverListSeparated(
        controller: model.viewController,
      );
    default:
      return const SizedBox.shrink();
  }
}

Widget _buildSliverGrid(ElementPropertyView model) {
  GridConstructor widgetType;

  if (!model.controlled) {
    widgetType = GridConstructor.fromValue(
      model.attributes.payload.getString(key: "constructor"),
    );
  } else {
    widgetType = GridConstructor.fromValue(
      model.viewController.attributes.payload.getString(key: "constructor"),
    );
  }

  switch (widgetType) {
    case GridConstructor.common:
    case GridConstructor.count:
    case GridConstructor.extent:
      if (!model.controlled) {
        return DuitSliverGrid(
          constructor: widgetType,
          attributes: model.attributes,
          children: model.children.map(_buildWidget).toList(),
        );
      } else {
        return DuitControlledSliverGrid(
          constructor: widgetType,
          controller: model.viewController,
          children: model.children.map(_buildWidget).toList(),
        );
      }
    case GridConstructor.builder:
      return DuitSliverGridBuilder(
        controller: model.viewController,
      );
  }
}

Widget _buildWrap(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledWrap(
        controller: model.viewController,
        children: model.children.map(_buildWidget).toList(),
      ),
    false => DuitWrap(
        attributes: model.attributes,
        children: model.children.map(_buildWidget).toList(),
      ),
  };
}

Widget _buildViewConsumer(ElementPropertyView model) {
  return DuitViewConsumer(
    controller: model.viewController,
  );
}

Widget _buildCustomWidget(DuitElement model) {
  final tag = model.tag;
  if (tag == null) return const SizedBox.shrink();

  final element = model.element;
  final children = element.containsKey("children")
      ? (element["children"] as List).map(_buildWidget).toList()
      : <Widget>[];

  final builder = DuitRegistry.getBuildFactory(tag);
  return builder?.call(model, children) ?? const SizedBox.shrink();
}

Widget _buildWidget(widgetModel) {
  return switch (widgetModel) {
    DuitElement() => _buildFromElementPropertyView(widgetModel.element),
    ElementPropertyView() => _buildFromElementPropertyView(widgetModel),
    _ => const SizedBox.shrink(),
  };
}

Widget _buildFromElementPropertyView(ElementPropertyView model) {
  // Support rendering of Custom widgets at any level in the tree
  if (model.type == ElementType.custom) {
    return _buildCustomWidget(DuitElement.wrap(model));
  }

  final buildFn = _buildFnLookup[model.type];

  if (buildFn != null) {
    return buildFn(model);
  } else if (throwOnUnspecifiedWidgetType) {
    throw ArgumentError("Unspecified widget type: ${model.type}");
  } else {
    return const SizedBox.shrink();
  }
}
