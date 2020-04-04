import 'package:flutter/foundation.dart';

class Chat {
  final String message;
  final int date;

  Chat({
    @required this.message,
    @required this.date,
  });
}

class ChatState {
  final Map<String, Chat> chats;

  ChatState({@required this.chats});

  ChatState copyWith({Map chats}) {
    final newChats = Map<String, Chat>();

    if (chats != null) newChats.addEntries(chats.entries);

    if (this.chats != null) newChats.addEntries(this.chats.entries);

    return ChatState(chats: newChats);
  }
}

ChatState replaceWith({Map<String, Chat> chats}) {
  return ChatState(chats: chats);
}
