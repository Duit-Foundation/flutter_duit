---
name: duit-maintainer
description: Creates new Flutter widgets following Duit framework patterns, writes comprehensive tests, and performs code reviews. Use when adding widgets, reviewing widget implementations, or maintaining the flutter_duit package.
---

# Duit Maintainer

## Quick Start

When working on flutter_duit widgets, follow these patterns consistently across all implementations.

## Creating New Widgets

### Step 1: Implement Widget Classes

Create widget implementation file in `lib/src/ui/widgets/` following this pattern:

```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class Duit[WidgetName] extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;  // or final List<Widget?> children;

  const Duit[WidgetName]({
    required this.attributes,
    required this.child,  // or this.children
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return [WidgetName](
      key: ValueKey(attributes.id),
      // ... widget-specific properties using attrs methods
      child: child,  // or children
    );
  }
}

class DuitControlled[WidgetName] extends StatefulWidget {
  final UIElementController controller;
  final Widget child;  // or final List<Widget?> children;

  const DuitControlled[WidgetName]({
    required this.controller,
    required this.child,  // or this.children
    super.key,
  });

  @override
  State<DuitControlled[WidgetName]> createState() =>
      _DuitControlled[WidgetName]State();
}

class _DuitControlled[WidgetName]State extends State<DuitControlled[WidgetName]>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return [WidgetName](
      key: ValueKey(widget.controller.id),
      // ... widget-specific properties using attributes
      child: widget.child,  // or widget.children
    );
  }
}
```

**Key Patterns:**

- Always create both Duit[WidgetName] (non-controlled) and DuitControlled[WidgetName] (controlled)
- Controlled widgets must extend StatefulWidget and mix in ViewControllerChangeListener
- The ViewControllerChangeListener mixin provides the `late DuitDataSource attributes` property, allowing direct access to `attributes.getBool()`, `attributes.getDouble()`, etc. in controlled widget state
- Call `attachStateToController(widget.controller)` in initState
- Use `ValueKey(attributes.id)` for non-controlled, `ValueKey(widget.controller.id)` for controlled
- Access attributes via `attributes.payload` in non-controlled widgets
- Access attributes via `attributes` (provided by ViewControllerChangeListener mixin) in controlled widgets
- **Themes are applied automatically via ViewAttribute.from() in widget_from_element.dart** - themes are merged during ViewAttribute creation before reaching the widget implementation
- Widget implementation code does NOT need to handle theme application explicitly - attributes received already have theme data merged

### Step 2: Register Widget Type

Add to `lib/src/ui/element_type.dart`:

1. Add enum value:

```dart
[widgetName](
  name: "[WidgetName]",
  isControlledByDefault: false,  // or true for interactive widgets
  childRelation: 0,  // 0=none, 1=single, 2=multiple, 3=component, 4=fragment
),
```

1. Add to lookup table (at end of file):

```dart
  "[WidgetName]": ElementType.[widgetName],
```

**Child Relations:**

- 0: Leaf widgets (Text, Image, TextField)
- 1: Single child wrapper (Container, Padding, Center)
- 2: Multiple children (Row, Column, Stack, Visibility)
- 3: Component content
- 4: Fragment content

### Step 3: Create Build Function

Add to `lib/src/ui/widget_from_element.dart`:

```dart
Widget _build[WidgetName](ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlled[WidgetName](
        controller: model.viewController,
        child: _buildWidget(model.child),  // or children
      ),
    false => Duit[WidgetName](
        attributes: model.attributes,
        child: _buildWidget(model.child),  // or children
      ),
  };
}
```

For multi-child widgets with nullable children:

```dart
Widget _build[WidgetName](ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);
  return switch (model.controlled) {
    true => DuitControlled[WidgetName](
        controller: model.viewController,
        children: children,
      ),
    false => Duit[WidgetName](
        attributes: model.attributes,
        children: children,
      ),
  };
}
```

### Step 4: Add to Build Function Lookup

Add to `lib/src/ui/build_fn_lookup.dart`:

```dart
  ElementType.[widgetName]: _build[WidgetName],
```

### Step 5: Export Widget

Add to `lib/src/ui/widgets/index.dart`:

```dart
export "[widget_name].dart";
```

### Step 6: Use AnimatedAttributes Mixin (for animatable properties)

If the widget has properties of types that support animation (e.g., width/height, Offset, and other types implementing `.lerp`), apply the `AnimatedAttributes` mixin.

The `AnimatedAttributes` mixin provides the `mergeWithDataSource` method that merges the widget's attributes with animated properties from the `DuitAnimationContext` if animation is active.

**When to use AnimatedAttributes:**

Apply this mixin when the widget has animatable properties such as:

- Numeric values: `width`, `height`, `opacity`, `scale`
- Position/offset: `Offset`, `Size`
- Colors and other interpolatable types

**Implementation pattern:**

```dart
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/animations/animated_props.dart";

class Duit[WidgetName] extends StatelessWidget with AnimatedAttributes {
  final ViewAttribute attributes;
  final Widget child;

  const Duit[WidgetName]({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = mergeWithDataSource(context, attributes.payload);
    return [WidgetName](
      key: ValueKey(attributes.id),
      // ... widget-specific properties using attrs methods
      // Properties will use animated values if animation is active
      width: attrs.getDouble(key: "width"),
      height: attrs.getDouble(key: "height"),
      child: child,
    );
  }
}
```

For controlled widgets:

```dart
class _DuitControlled[WidgetName]State extends State<DuitControlled[WidgetName]>
    with ViewControllerChangeListener {
  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    final attrs = widget.mergeWithDataSource(context, attributes);
    return [WidgetName](
      key: ValueKey(widget.controller.id),
      // ... widget-specific properties
      width: attrs.getDouble(key: "width"),
      height: attrs.getDouble(key: "height"),
      child: widget.child,
    );
  }
}
```

**How mergeWithDataSource works:**

The method checks for the following conditions:

1. If the dataSource has a parentBuilderId
2. If a DuitAnimationContext exists in the widget tree
3. If the animation context's parentId matches the dataSource's parentBuilderId
4. If there are affected properties to animate

If all conditions are met, it merges the animated values from the animation context streams with the current dataSource, allowing animated values to override static ones.

**Key points:**

- Apply `AnimatedAttributes` mixin to both non-controlled and controlled widget classes
- For non-controlled widgets: call `mergeWithDataSource(context, attributes.payload)`
- For controlled widgets: call `widget.mergeWithDataSource(context, attributes)` (attributes provided by ViewControllerChangeListener)
- Use the merged attributes to extract all animatable properties
- The mixin gracefully handles cases where no animation is active (returns original dataSource)

## Working with Themes

### Theme Overview

Duit framework provides a theming system that allows you to define reusable styling for widgets. Themes are defined globally and applied automatically when widgets specify a `theme` attribute in their JSON definition.

### How Themes Work

1. **Theme Definition**: Themes are defined in a JSON structure and processed by `DuitThemePreprocessor`
2. **Theme Tokens**: Each widget type has an associated `ThemeToken` class that defines which attributes can be themed
3. **Theme Application**: When a widget specifies `theme: "theme_name"`, the theme data is merged with the widget's attributes during `ViewAttribute.from()` creation
4. **Excluded Fields**: Each ThemeToken has a list of excluded fields that should NOT be themed (e.g., callbacks, data, structural properties)

### Theme System Components

#### Theme Tokens

Theme tokens are defined in `lib/src/ui/theme/tokens.dart`. Each token type excludes specific fields that should not be part of the theme:

- **TextThemeToken**: Excludes `data` (the text content itself)
- **ImageThemeToken**: Excludes `src`, `byteData` (image source data)
- **AttendedWidgetThemeToken**: Excludes `value` (for Checkbox, Switch, etc.)
- **RadioThemeToken**: Excludes animation-related properties
- **SliderThemeToken**: Excludes callback properties (`onChanged`, `onChangeStart`, `onChangeEnd`)
- **ImplicitAnimatableThemeToken**: Excludes `onEnd` callback
- **ExcludeGestureCallbacksThemeToken**: Excludes all gesture callbacks (`onTap`, `onDoubleTap`, etc.)
- **ExcludeChildThemeToken**: Excludes child subviews (`title`, `actions`, `body`, etc. for AppBar/Scaffold)
- **DynamicChildHolderThemeToken**: Excludes `childObjects`, `constructor`
- **AnimatedPropOwnerThemeToken**: Excludes animation-related properties
- **DefaultThemeToken**: No exclusions (for widgets that can be fully themed)

#### Theme Preprocessor

The `DuitThemePreprocessor` class (`lib/src/ui/theme/preprocessor.dart`) handles theme token creation. It maps widget types to appropriate theme tokens:

```dart
final class DuitThemePreprocessor extends ThemePreprocessor {
  const DuitThemePreprocessor({
    super.customWidgetTokenizer,
    super.overrideWidgetTokenizer,
  });

  @override
  ThemeToken createToken(String widgetType, Map<String, dynamic> themeData) {
    final type = ElementType.valueOrNull(widgetType);
    return switch (type) {
      ElementType.text => TextThemeToken(themeData),
      ElementType.image => ImageThemeToken(themeData),
      ElementType.checkbox || ElementType.switch_ || ElementType.textField || ElementType.meta =>
        AttendedWidgetThemeToken(themeData, widgetType),
      // ... more mappings
      _ => customWidgetTokenizer?.call(widgetType, themeData) ?? const UnknownThemeToken(),
    };
  }
}
```

### Theme Initialization

Themes are initialized at application startup:

```dart
import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/theme/preprocessor.dart';

// Define your themes
final themePreprocessor = const DuitThemePreprocessor().tokenize({
  "primary_text": {
    "type": "Text",
    "data": {
      "style": {
        "fontSize": 16.0,
        "fontWeight": "w600",
        "color": "#333333",
      },
      "textAlign": "left",
    },
  },
  "secondary_text": {
    "type": "Text",
    "data": {
      "style": {
        "fontSize": 14.0,
        "color": "#666666",
      },
    },
  },
  "primary_button": {
    "type": "ElevatedButton",
    "data": {
      "style": {
        "backgroundColor": "#2196F3",
        "foregroundColor": "#FFFFFF",
        "padding": {"all": 16.0},
      },
    },
  },
});

// Initialize Duit with themes
await DuitRegistry.initialize(
  theme: themePreprocessor,
);
```

### Using Themes in Widget JSON

To apply a theme to a widget, use the `theme` attribute:

```json
{
  "type": "Text",
  "id": "title",
  "controlled": false,
  "theme": "primary_text",
  "attributes": {
    "data": "Hello World"
  }
}
```

The theme will be merged with the widget's attributes. If both theme and attributes specify the same property, the behavior depends on `overrideRule`:

- `themeOverlay` (default): Widget attributes take precedence
- `themePriority`: Theme values take precedence

```json
{
  "type": "Text",
  "id": "title",
  "controlled": false,
  "theme": "primary_text",
  "overrideRule": "themePriority",
  "attributes": {
    "data": "Hello World",
    "textAlign": "center"  // This would be overridden by theme if themePriority
  }
}
```

### Custom Theme Tokens

For custom widget types, you can create custom theme tokens:

```dart
final class CustomWidgetThemeToken extends ThemeToken {
  CustomWidgetThemeToken(Map<String, dynamic> data)
      : super(
          const {}, // No excluded fields - allow all to be themed
          data,
          "CustomWidget",
        );
}
```

Then provide it to the preprocessor:

```dart
final preprocessor = DuitThemePreprocessor(
  customWidgetTokenizer: (type, themeData) {
    switch (type) {
      case "CustomWidget":
        return CustomWidgetThemeToken(themeData);
      default:
        return null;
    }
  },
);
```

Or override existing widget tokenization:

```dart
final preprocessor = DuitThemePreprocessor(
  overrideWidgetTokenizer: (type, themeData) {
    switch (type) {
      case "Text":
        return CustomTextThemeToken(themeData);  // Override default TextThemeToken
      default:
        return null;  // Use default tokenization
    }
  },
);
```

### Theme Token Selection Guide

When implementing a new widget, select the appropriate theme token type based on the widget's characteristics:

| Widget Type | Theme Token | When to Use |
|-------------|-------------|-------------|
| Text widgets | `TextThemeToken` | Text content should be excluded from theme |
| Image widgets | `ImageThemeToken` | Image source (src, byteData) should be excluded |
| Interactive widgets with value (Checkbox, Switch, etc.) | `AttendedWidgetThemeToken` | `value` field should be excluded |
| Radio buttons | `RadioThemeToken` | Animation properties excluded |
| Sliders | `SliderThemeToken` | Callbacks (`onChanged`, etc.) excluded |
| Implicit animations | `ImplicitAnimatableThemeToken` | `onEnd` callback excluded |
| Gesture handlers | `ExcludeGestureCallbacksThemeToken` | All gesture callbacks excluded |
| Layout widgets with children (AppBar, Scaffold) | `ExcludeChildThemeToken` | Child subviews excluded |
| Lists/Grids | `DynamicChildHolderThemeToken` | `childObjects` excluded |
| Containers with animatable properties | `AnimatedPropOwnerThemeToken` | Animation properties excluded |
| Simple widgets | `DefaultThemeToken` | No exclusions needed |

### Important Notes for Widget Implementation

**Widget implementations do NOT need to handle themes explicitly.** The theme merging happens in `ViewAttribute.from()` during widget tree construction. Your widget code receives attributes that already have theme data merged:

```dart
// In widget_from_element.dart - themes are applied here automatically
Widget _buildText(ElementPropertyView model) {
  // model.attributes already has theme data merged
  return switch (model.controlled) {
    true => DuitControlledText(controller: model.viewController),
    false => DuitText(attributes: model.attributes),
  };
}

// In your widget implementation - just use attributes directly
@override
Widget build(BuildContext context) {
  final attrs = attributes.payload;  // or mergeWithDataSource for animated props
  return Text(
    attrs.getString(key: "data"),  // Theme already merged into attributes
    style: attrs.textStyle(),
  );
}
```

### Theme Testing

When testing widgets that support themes:

1. Initialize the registry with theme preprocessor in `setUpAll`
2. Create tests that verify theme attributes are applied
3. Test override rules (`themeOverlay` vs `themePriority`)

```dart
import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  setUpAll(() async {
    final proc = const DuitThemePreprocessor().tokenize({
      "text_theme": {
        "type": "Text",
        "data": {
          "style": {
            "fontSize": 24.0,
            "color": "#FF0000",
          },
        },
      },
    });
    await DuitRegistry.initialize(theme: proc);
  });

  testWidgets("must apply theme attributes", (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: DuitViewHost.withDriver(
          driver: XDriver.static({
            "type": "Text",
            "id": "text_1",
            "theme": "text_theme",
            "attributes": {"data": "Themed Text"},
          }),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.byKey(const ValueKey("text_1")));
    expect(textWidget.style?.fontSize, equals(24.0));
    expect(textWidget.style?.color, equals(const Color(0xFFFF0000)));
  });
}
```

## Writing Tests

### Test File Pattern

Create test file in `test/` following this structure:

```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "[WidgetName]",
    "id": "[widget_name]_test",
    "controlled": isControlled,
    "attributes": {
      // required attributes
    },
    "child": {  // or "children": [...]
      "type": "Container",
      "id": "con",
      "controlled": false,
      "attributes": {"color": "#DCDCDC", "width": 50, "height": 50},
    },
  };
}

void main() {
  group("Duit[WidgetName] widget tests", () {
    testWidgets("check widget", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost.withDriver(
            driver: XDriver.static(
              _createWidget(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey("[widget_name]_test"));
      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = XDriver.static(
          _createWidget(true),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final widget = find.byKey(const ValueKey("[widget_name]_test"));
        expect(widget, findsOneWidget);

        // Verify initial state
        final initialWidget = tester.widget<[WidgetName]>(widget);
        expect(initialWidget.property, expectedValue);

        await driver.asInternalDriver.updateAttributes(
          "[widget_name]_test",
          {
            "property": newValue,
          },
        );

        await tester.pumpAndSettle();

        // Verify updated state
        final updatedWidget = tester.widget<[WidgetName]>(widget);
        expect(updatedWidget.property, newValue);
      },
    );
  });
}
```

**Test Guidelines:**

- Always use `XDriver.static` for widget tests
- Create helper function `_createWidget([bool isControlled = false])`
- Test both non-controlled and controlled versions
- Use `find.byKey(const ValueKey("..."))` to locate widgets
- For controlled widgets, test `updateAttributes` functionality
- Use `pumpDriver(tester, driver.asInternalDriver)` for controlled widget tests
- Import `utils.dart` for helper functions like `pumpDriver`

## Attribute Access Patterns

When accessing attributes in widgets:

```dart
final attrs = attributes.payload;  // or use attributes directly in controlled widgets

// Double values
width: attrs.tryGetDouble(key: "width")
height: attrs.getDouble(key: "height")  // throws if missing
attrs.getDouble(key: "value", defaultValue: 0.0)

// Boolean values
visible: attrs.getBool("visible", defaultValue: true)

// String values
title: attrs.getString(key: "title")

// Color values
color: attrs.tryParseColor(key: "color")
decoration: attrs.decoration()

// EdgeInsets values
padding: attrs.edgeInsets()
margin: attrs.edgeInsets(key: "margin")

// Alignment values
alignment: attrs.alignment()

// BoxConstraints values
constraints: attrs.boxConstraints()
```

## Code Review Checklist

When reviewing widget implementations:

- [ ] Both Duit[WidgetName] and DuitControlled[WidgetName] classes exist
- [ ] Controlled widget extends StatefulWidget and mixes ViewControllerChangeListener
- [ ] Controlled widget state uses `attributes` property directly (provided by ViewControllerChangeListener mixin)
- [ ] `attachStateToController` called in initState
- [ ] Correct key usage: ValueKey(attributes.id) or ValueKey(widget.controller.id)
- [ ] ElementType enum value added with correct childRelation
- [ ] _stringToTypeLookupTable entry added
- [ ] _build[WidgetName] function exists in widget_from_element.dart
- [ ] Build function added to _buildFnLookup
- [ ] Widget exported in widgets/index.dart
- [ ] AnimatedAttributes mixin applied if widget has animatable properties (width, height, Offset, etc.)
- [ ] mergeWithDataSource used to get merged attributes in widgets with AnimatedAttributes
- [ ] Tests exist for both controlled and non-controlled versions
- [ ] Tests use XDriver.static
- [ ] Tests verify attribute updates for controlled widgets
- [ ] Attribute access uses proper methods (tryGetDouble, getBool, etc.)
- [ ] Default values provided where appropriate

### Theme Support Checklist (REQUIRED for ALL widgets)

- [ ] Widget type is added to `DuitThemePreprocessor.createToken()` in `lib/src/ui/theme/preprocessor.dart`
- [ ] Appropriate theme token class is selected and instantiated for the widget type
- [ ] Theme token correctly excludes fields that should NOT be themed (callbacks, data, structural properties)
- [ ] Tests verify theme application for the widget (theme data merged with attributes)
- [ ] Tests cover both `themeOverlay` and `themePriority` override rules if applicable
- [ ] Widget implementation does NOT explicitly handle theme application (themes are applied automatically via ViewAttribute.from())
- [ ] If widget has special theme requirements, custom theme token is documented in implementation comments

## Widget Type Decision Flow

Determine child relation:

```
Widget has no children → childRelation: 0
Widget has one child → childRelation: 1
Widget has multiple children → childRelation: 2
Widget is component → childRelation: 3
Widget is fragment → childRelation: 4
```

Determine isControlledByDefault:

```
User interaction required (Button, TextField, etc.) → true
State management needed (Animation, etc.) → true
Static wrapper only → false
```

## Common Mistakes to Avoid

1. **Missing controlled version**: Always create both Duit[WidgetName] and DuitControlled[WidgetName]
2. **Wrong key type**: Use `ValueKey` not just `Key`
3. **Forgetting attachStateToController**: Must call this in initState for controlled widgets
4. **Wrong childRelation**: Check widget signature for single vs multiple children
5. **Missing tests**: Every widget must have tests covering both versions
6. **Not testing updates**: Controlled widgets must test attribute updates
7. **Hard-coded values**: Always use attrs methods to extract values from JSON
8. **Missing AnimatedAttributes for animatable properties**: If a widget has properties that support animation (width, height, Offset, etc.), always apply the AnimatedAttributes mixin and use mergeWithDataSource to merge animated values
