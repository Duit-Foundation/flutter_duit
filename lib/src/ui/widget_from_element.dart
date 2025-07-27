part of 'element_property_view.dart';

@preferInline
Widget _buildText(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledText(controller: model.viewController),
    false => DuitText(attributes: model.attributes),
  };
}

@preferInline
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

@preferInline
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

@preferInline
Widget _buildElevatedButton(ElementPropertyView model) => DuitElevatedButton(
      controller: model.viewController,
      child: _buildWidget(model.child),
    );

@preferInline
Widget _buildTextField(ElementPropertyView model) => DuitTextField(
      controller: model.viewController,
    );

@preferInline
Widget _buildSlider(ElementPropertyView model) => DuitSlider(
      controller: model.viewController,
    );

@preferInline
Widget _buildSwitch(ElementPropertyView model) => DuitSwitch(
      controller: model.viewController,
    );

@preferInline
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

@preferInline
Widget _buildCheckbox(ElementPropertyView model) => DuitCheckbox(
      controller: model.viewController,
    );

@preferInline
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

@preferInline
Widget _buildRadioGroupContext(ElementPropertyView model) {
  return DuitRadioGroupContextProvider(
    controller: model.viewController,
    child: _buildWidget(model.child),
  );
}

Widget _buildMock(ElementPropertyView model) => throw UnimplementedError();

@preferInline
Widget _buildColumn(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledColumn(
        controller: model.viewController,
        children: model.children.map(_buildText).toList(),
      ),
    false => DuitColumn(
        attributes: model.attributes,
        children: model.children.map(_buildText).toList(),
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

@preferInline
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

Widget _buildWidget(dynamic widgetModel) {
  return switch (widgetModel) {
    DuitElement(type: ElementType.custom) => _buildCustomWidget(widgetModel),
    DuitElement() => _buildFromElementPropertyView(widgetModel.element),
    ElementPropertyView() => _buildFromElementPropertyView(widgetModel),
    _ => const SizedBox.shrink(),
  };
}

@preferInline
Widget _buildFromElementPropertyView(ElementPropertyView model) {
  final builder = _buildFnLookup[model.type];
  return builder?.call(model) ?? const SizedBox.shrink();
}
