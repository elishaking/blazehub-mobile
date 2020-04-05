import 'package:blazehub/models/chat.dart';
import 'package:blazehub/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/chat.dart';

class ChatMessage extends StatelessWidget {
  final String chatID;
  final String friendID;

  final newMessage = {'text': ''};
  final TextEditingController _editingController = TextEditingController();

  ChatMessage(this.chatID, this.friendID);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatViewModel>(
      converter: (Store<AppState> store) => ChatViewModel.create(store),
      builder: (context, model) {
        final chats = model.chatState.chats;
        final hasMessages = chats == null ? false : chats.containsKey(chatID);

        if (!hasMessages) {
          // model.listenForMessages(chatID);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(model.friendState.friends[friendID].name),
            centerTitle: true,
          ),
          body: hasMessages
              ? Container()
              : Center(
                  child: Text('Start Chatting...'),
                ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              child: TextFormField(
                controller: _editingController,
                onChanged: (String text) {
                  newMessage['text'] = text;
                },
                decoration: InputDecoration(
                  hintText: 'Write a message',
                  filled: true,
                  fillColor: AppColors.light,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (newMessage['text'].isNotEmpty) {
                        final message = Message(
                          text: newMessage['text'],
                          date: DateTime.now().millisecondsSinceEpoch,
                          userID: model.authState.user.id,
                        );

                        // model
                        //     .addMessage(message, chatID)
                        //     .then((isSuccessful) {
                        //   if (isSuccessful) {
                        //     _editingController.clear();
                        //   }
                        // });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
