import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/chat.dart';

class ChatMessage extends StatelessWidget {
  final String chatID;

  const ChatMessage(this.chatID);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatViewModel>(
      converter: (Store<AppState> store) => ChatViewModel.create(store),
      builder: (context, model) {
        final hasMessages = model.chatState.chats?.containsKey(chatID);

        if (!hasMessages) {
          model.listenForMessages(chatID);
        }

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Start Chatting...'),
          ),
        );
      },
    );
  }
}
