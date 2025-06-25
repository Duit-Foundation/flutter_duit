[![Coverage Status](https://coveralls.io/repos/github/Duit-Foundation/flutter_duit/badge.svg?branch=main)](https://coveralls.io/github/Duit-Foundation/flutter_duit?branch=main) ![Pub Version](https://img.shields.io/pub/v/flutter_duit) ![Pub Points](https://img.shields.io/pub/points/flutter_duit) ![GitHub Org's stars](https://img.shields.io/github/stars/Duit-Foundation)




# Duit - drived UI tooklit. 

[***Duit***](https://duit.pro/en/) is an actively growing open-source ecosystem of libraries and tools aimed at helping developers easily and effectively implement the backend-driven UI approach in their Flutter-based applications.

The framework consists of several parts:

- Flutter package
- [Go DSL](https://github.com/lesleysin/duit_go)
- [TypeScript DSL](https://github.com/lesleysin/duit_js)

#### Are you using Duit in production? [Contact us](mailto://duit_foundation@gmail.com) and tell us about your experience!

## Core features

- Flexible framework architecture that allows easy integration with new and existing Flutter applications
- Support for
  different [network protocols](https://duit.pro/en/docs/core_concepts/transport_layer) (http,
  websocket) with [extension ability](https://duit.pro/en/docs/advanced_tech/transport_override) 
- Event-drived state management with [Actions & Events API](https://duit.pro/en/docs/core_concepts/actions_events/)
- Ability to add your
  own [custom widgets](https://duit.pro/en/docs/advanced_tech/custom/about) on the Flutter and backend side
- Powerful [templating system (Components)](https://duit.pro/en/docs/advanced_tech/components/about) to reduce json size and code coherence
- Ability to [execute dynamically passed scripts](https://duit.pro/en/docs/advanced_tech/scripting) in the integrated runtime environment to create dynamically changing business logic

### Learn more Duit features on our [website](https://duit.pro/en/)

## Usage example
0. Install flutter_duit

```text
flutter pub add flutter_duit
```


1. Create DuitDriver instance.

It is responsible for displaying the UI, updating the state of widgets, and calling widget-related
actions.

```dart
final driver = DuitDriver(
  "/layout",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
```

2. Embed the DuitViewHost widget into your application in the build method.

```dart
DuitViewHost(
  driver: driver,
  placeholder: const CircularProgressIndicator(),
),
```

## Project roadmap

- New event types
- Expanding the widget collection
- Increasing unit test coverage of the code base
- Expansion and improvement of documentation quality
- New DSL (eg. for Dart)

[Learn more about project state](https://github.com/Duit-Foundation/flutter_duit/issues)

## Contributors

<a href="https://github.com/Duit-Foundation/flutter_duit/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Duit-Foundation/flutter_duit" />
</a>

## License

MIT



