# Pluggable Widget Collections

Этот документ описывает архитектурные изменения, необходимые для поддержки подключаемых коллекций виджетов в виде отдельных пакетов (по аналогии с планируемым разделением `flutter/material.dart` и `flutter/cupertino.dart`).

## Контекст

В текущей реализации `flutter_duit` все виджеты — как базовые (`widgets`), так и Material-специфичные (`AppBar`, `Scaffold`, `Card`, `InkWell` и др.) — собраны в одном пакете. Цель — сделать возможным вынесение коллекций виджетов (например, Material, Cupertino) в отдельные подключаемые пакеты.

> **Важно:** `duit_kernel` изменений **не требует**. Весь механизм реализуется внутри `flutter_duit`.

---

## Точки жёсткой связи

### 1. `ElementType` — закрытый enum

```dart
// lib/src/ui/element_type.dart
enum ElementType {
  row(...),
  appBar(...),
  scaffold(...),
  // ... 60+ значений ...
}
```

`ElementType` — это sealed Dart enum. Внешние пакеты не могут добавлять новые значения.

Ключевое: значение `childRelation` из этого enum используется **в парсере дерева** (`DuitElement.fromJson`):

```dart
switch (element.type.childRelation) {
  case 1: // single child
  case 2: // multi children
  case 3: // component
  case 4: // fragment
}
```

Это значит, что для внешнего типа нужно знать `childRelation` уже на этапе парсинга — до рендеринга.

### 2. `_buildFnLookup` и `_stringToTypeLookupTable` — `const`-Maps

```dart
// lib/src/ui/build_fn_lookup.dart
const _buildFnLookup = <ElementType, BuildFn>{
  ElementType.text: _buildText,
  ElementType.appBar: _buildAppBar,
  // ...
};

// lib/src/ui/element_type.dart
const _stringToTypeLookupTable = <String, ElementType>{
  "AppBar": ElementType.appBar,
  // ...
};
```

Оба — compile-time константы. Внешний пакет не может их расширить.

### 3. `_processElement` использует свойства `ElementType` при парсинге

```dart
// lib/src/ui/element_property_view.dart
if (element.type.mayHaveRelatedAction) { ... }
if (element.controlled || element.type.isControlledByDefault) { ... }
```

Метаданные (`isControlledByDefault`, `mayHaveRelatedAction`) нужны уже на этапе парсинга, поэтому их необходимо включить в регистрацию внешних типов.

### 4. Прямой импорт `flutter/material.dart` в виджетах

```dart
// lib/src/ui/widgets/app_bar.dart
import "package:flutter/material.dart";
```

`AppBar`, `Scaffold`, `Card`, `InkWell`, `ElevatedButton` и другие Material-виджеты имеют прямые импорты. Чтобы вынести их в отдельный пакет `flutter_duit_material`, код должен физически переехать.

---

## Предлагаемые изменения

### Шаг 1. Новый класс `ExternalElementDescriptor`

Дескриптор описывает внешний тип виджета — его метаданные и функцию рендеринга:

```dart
// lib/src/ui/external_element_descriptor.dart
class ExternalElementDescriptor {
  final int childRelation;
  final bool isControlledByDefault;
  final bool mayHaveRelatedAction;
  final BuildFn buildFn;

  const ExternalElementDescriptor({
    required this.childRelation,
    required this.buildFn,
    this.isControlledByDefault = false,
    this.mayHaveRelatedAction = false,
  });
}
```

### Шаг 2. Новый класс `DuitWidgetRegistry`

Мутируемый реестр для внешних типов, дополняющий `const _buildFnLookup`:

```dart
// lib/src/ui/widget_registry.dart
final class DuitWidgetRegistry {
  static final Map<String, ExternalElementDescriptor> _external = {};

  static void register(String typeName, ExternalElementDescriptor descriptor) {
    _external[typeName] = descriptor;
  }

  static ExternalElementDescriptor? getDescriptor(String typeName) =>
      _external[typeName];
}
```

### Шаг 3. `ElementType.external` — sentinel-значение

Добавить одно значение в enum как маркер для всех внешних типов:

```dart
external(
  name: "External",
  isControlledByDefault: false,
  childRelation: 0, // метаданные переопределяются через DuitWidgetRegistry
),
```

Обновить `ElementType.value()`:

```dart
static ElementType value(String name) =>
    _stringToTypeLookupTable[name] ??
    (DuitWidgetRegistry.getDescriptor(name) != null
        ? ElementType.external
        : throw ArgumentError("Unknown element type: $name"));
```

### Шаг 4. Сохранение оригинального строкового имени

Геттер `type` в `ElementPropertyView` затирает строку объектом enum. Для `external` нужно сохранить оригинал:

```dart
ElementType get type {
  final raw = json["type"];
  if (raw is ElementType) return raw;
  final resolved = ElementType.value(raw as String);
  json["type"] = resolved;
  if (resolved == ElementType.external) {
    json["_externalTypeName"] = raw;
  }
  return resolved;
}

String? get externalTypeName => json["_externalTypeName"];
```

### Шаг 5. Обновление `DuitElement.fromJson`

Для `ElementType.external` `childRelation` берётся из `DuitWidgetRegistry`:

```dart
int _resolveChildRelation(ElementPropertyView element) {
  if (element.type == ElementType.external) {
    final name = element.externalTypeName;
    return DuitWidgetRegistry.getDescriptor(name!)?.childRelation ?? 0;
  }
  return element.type.childRelation;
}

// Заменить switch (element.type.childRelation) на:
switch (_resolveChildRelation(element)) { ... }
```

### Шаг 6. Обновление `_processElement`

```dart
void _processElement(Map<String, dynamic> data, UIDriver driver) {
  final element = ElementPropertyView._(data);

  final descriptor = element.type == ElementType.external
      ? DuitWidgetRegistry.getDescriptor(element.externalTypeName!)
      : null;

  final isControlledByDefault = descriptor?.isControlledByDefault
      ?? element.type.isControlledByDefault;

  final mayHaveRelatedAction = descriptor?.mayHaveRelatedAction
      ?? element.type.mayHaveRelatedAction;

  // ... остальная логика с заменёнными свойствами
}
```

### Шаг 7. Обновление `_buildFromElementPropertyView`

```dart
Widget _buildFromElementPropertyView(ElementPropertyView model) {
  if (model.type == ElementType.custom) {
    return _buildCustomWidget(DuitElement.wrap(model));
  }

  if (model.type == ElementType.external) {
    final name = model.externalTypeName;
    if (name != null) {
      final descriptor = DuitWidgetRegistry.getDescriptor(name);
      if (descriptor != null) return descriptor.buildFn(model);
    }
    return throwOnUnspecifiedWidgetType
        ? throw ArgumentError("Unspecified external widget type: $name")
        : const SizedBox.shrink();
  }

  final buildFn = _buildFnLookup[model.type];
  if (buildFn != null) return buildFn(model);

  return throwOnUnspecifiedWidgetType
      ? throw ArgumentError("Unspecified widget type: ${model.type}")
      : const SizedBox.shrink();
}
```

### Шаг 8. Интерфейс `DuitWidgetCollection`

Точка входа для любого стороннего пакета:

```dart
// lib/src/ui/widget_collection.dart
abstract interface class DuitWidgetCollection {
  Map<String, ExternalElementDescriptor> get descriptors;

  void install() {
    for (final entry in descriptors.entries) {
      DuitWidgetRegistry.register(entry.key, entry.value);
    }
  }
}
```

---

## Целевая структура пакетов

| Пакет | Содержимое |
|---|---|
| `duit_kernel` | Ядро: драйвер, события, реестр компонентов, транспорт |
| `flutter_duit` | Базовые виджеты (`widgets`-слой Flutter) + инфраструктура |
| `flutter_duit_material` | `AppBar`, `Scaffold`, `Card`, `InkWell`, кнопки и др. |
| `flutter_duit_cupertino` | Cupertino-виджеты (будущее) |

---

## Пример: пакет `flutter_duit_material`

```dart
// flutter_duit_material/lib/flutter_duit_material.dart

class MaterialDuitWidgetCollection implements DuitWidgetCollection {
  @override
  Map<String, ExternalElementDescriptor> get descriptors => {
    "AppBar": ExternalElementDescriptor(
      childRelation: 2,
      buildFn: _buildAppBar,
    ),
    "Scaffold": ExternalElementDescriptor(
      childRelation: 2,
      buildFn: _buildScaffold,
    ),
    "Card": ExternalElementDescriptor(
      childRelation: 1,
      buildFn: _buildCard,
    ),
    "ElevatedButton": ExternalElementDescriptor(
      childRelation: 1,
      isControlledByDefault: true,
      mayHaveRelatedAction: true,
      buildFn: _buildElevatedButton,
    ),
    // ...
  };
}
```

Инициализация в приложении:

```dart
await DuitRegistry.initialize(...);
MaterialDuitWidgetCollection().install();
```

---

## Сводная таблица изменений

| Файл | Изменение |
|---|---|
| `lib/src/ui/element_type.dart` | Добавить `ElementType.external` sentinel |
| `lib/src/ui/element_property_view.dart` | Геттер `type`: сохранять `_externalTypeName`; `_processElement`: делегировать метаданные в `DuitWidgetRegistry` |
| `lib/src/ui/duit_element.dart` | `childRelation` для `external` брать из `DuitWidgetRegistry` |
| `lib/src/ui/widget_from_element.dart` | Добавить ветку для `ElementType.external` |
| `lib/src/ui/build_fn_lookup.dart` | Без изменений (`const` остаётся) |
| `lib/src/ui/external_element_descriptor.dart` | **Новый файл** |
| `lib/src/ui/widget_registry.dart` | **Новый файл** |
| `lib/src/ui/widget_collection.dart` | **Новый файл** |
