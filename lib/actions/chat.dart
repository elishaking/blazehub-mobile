import 'package:flutter/foundation.dart';

import 'package:blazehub/models/chat.dart';

class AddMessage {
  final Map<String, Message> payload;
  final String chatID;

  AddMessage(this.payload, {@required this.chatID});
}
