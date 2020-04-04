import 'package:blazehub/pages/chat.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final int date;
  final String userID;

  Message({
    @required this.text,
    @required this.date,
    @required this.userID,
  });
}

class Chat {
  final String chatID;
  final Map<String, Message> messages;

  Chat({
    @required this.chatID,
    @required this.messages,
  });
}

class ChatState {
  final Map<String, Chat> chats;

  ChatState({@required this.chats});

  ChatState copyWithMessage(String chatID, Map<String, Message> messages) {
    final newChats = Map<String, Chat>();
    if (chats != null) newChats.addAll(chats);

    if (newChats[chatID] == null)
      newChats.putIfAbsent(
        chatID,
        () => Chat(
          chatID: chatID,
          messages: messages,
        ),
      );
    else
      messages.forEach((messageKey, message) {
        newChats[chatID].messages[messageKey] = message;
      });

    return ChatState(chats: newChats);
  }

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
