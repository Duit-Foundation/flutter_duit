# Duit - drived UI tooklit.

***Duit*** is a server side UI framework for Flutter. It is used for creating widgets and server-side state management.

The framework consists of several parts:

- Flutter package (this repository)
- [Go backend adapter](https://github.com/lesleysin/duit_go)
- [Node JS backend adapter](https://github.com/lesleysin/duit_js)

The framework ensures that the layout model is received from the server, interacts with the backend via the Action API, and embeds custom components into the widget hierarchy processing pipeline. Duit is flexible and extensible, which allows it to create rich UI dynamically.

## Core features

- Initial connection to the server and receiving a layout
- Support for different network protocols (http, websocket)
- Pointed widget state update (updating only those widgets for which the server returned an "update")
- Actions API. A special protocol that allows the server to specify dependencies for an action associated with a widget.
- Ability to add your own custom widgets on the Flutter and backend side.

## Usage example

1. Create DuitDriver instance. 


It is responsible for displaying the UI, updating the state of widgets, and calling widget-related actions.


```dart
final driver = DUITDriver(
  "/layout1",
  transportOptions: HttpTransportOptions(
    defaultHeaders: {"Content-Type": "application/json"},
    baseUrl: "http://localhost:8999",
  ),
);
```

2. Embed the DuitViewHost widget into your application in the build method.

```dart
DuitViewHost(
  context: context,
  driver: driver,
  placeholder: const CircularProgressIndicator(),
),
```


