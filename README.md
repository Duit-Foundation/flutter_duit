# Duit - drived UI tooklit.

***Duit*** is a server side UI framework for Flutter. It is used for creating widgets and server-side state management.

The framework consists of several parts:

- Flutter package (this repository)
- [Go backend adapter](https://github.com/lesleysin/duit_go)
- [Node JS backend adapter](https://github.com/lesleysin/duit_js)

The framework ensures that the layout model is received from the server, interacts with the backend via the Action API, and embeds custom components into the widget hierarchy processing pipeline.

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


