import 'package:flutter_duit/src/utils/dev/message.dart';

base class DevComponentMessage extends DevMessage {
  DevComponentMessage(super.timestamp);
}

final class StartMergeMessage extends DevComponentMessage {
  StartMergeMessage() : super(DateTime.now());
}

final class EndMergeMessage extends DevComponentMessage {
  EndMergeMessage() : super(DateTime.now());
}

final class LogMergeInfo extends DevComponentMessage {
  LogMergeInfo() : super(DateTime.now());
}
