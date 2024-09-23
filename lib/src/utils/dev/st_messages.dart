sealed class DevStartUpMessage {
  final DateTime timestamp;

  DevStartUpMessage(this.timestamp);
}

final class ConnectionStartMessage extends DevStartUpMessage {
  ConnectionStartMessage() : super(DateTime.now());
}

final class ReqStartMessage extends DevStartUpMessage {
  ReqStartMessage() : super(DateTime.now());
}

final class ReqEndMessage extends DevStartUpMessage {
  ReqEndMessage() : super(DateTime.now());
}

final class DecodeStartMessage extends DevStartUpMessage {
  DecodeStartMessage() : super(DateTime.now());
}

final class DecodeEndMessage extends DevStartUpMessage {
  DecodeEndMessage() : super(DateTime.now());
}

final class ParseModelStartMessage extends DevStartUpMessage {
  ParseModelStartMessage() : super(DateTime.now());
}

final class ParseModelEndMessage extends DevStartUpMessage {
  ParseModelEndMessage() : super(DateTime.now());
}

final class RenderStartMessage extends DevStartUpMessage {
  RenderStartMessage() : super(DateTime.now());
}

final class RenderEndMessage extends DevStartUpMessage {
  RenderEndMessage() : super(DateTime.now());
}