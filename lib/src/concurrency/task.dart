sealed class Task {
  final String key;
  final dynamic payload;

  Task({
    required this.key,
    required this.payload,
  });
}

final class ShutdownTask extends Task {
  ShutdownTask() : super(key: "shutdown", payload: null);
}

final class ParseJsonTask extends Task {
  ParseJsonTask(dynamic data) : super(key: "parseJson", payload: data);
}

final class FillComponentPropertiesTask extends Task {
  FillComponentPropertiesTask(
    Map<String, dynamic> layout,
    Map<String, dynamic> data,
  ) : super(
          key: "fillComponentProperties",
          payload: {
            "layout": layout,
            "data": data,
          },
        );
}
