import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/models/chat.dart';
import 'package:blazehub/utils/date.dart';
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

  final ScrollController _messageListScrollController = ScrollController();

  ChatMessage(this.chatID, this.friendID);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatViewModel>(
      converter: (Store<AppState> store) => ChatViewModel.create(store),
      builder: (context, model) {
        final chats = model.chatState.chats;
        final hasMessages = chats == null ? false : chats.containsKey(chatID);

        if (!hasMessages) {
          model.listenForMessages(chatID);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(model.friendState.friends[friendID].name),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                model.cancelMessageListener();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 60),
            child: hasMessages
                ? MessageList(
                    model,
                    model.chatState.chats[chatID].messages,
                    _messageListScrollController,
                  )
                : Center(
                    child: Text('Start Chatting...'),
                  ),
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

                        model.addMessage(message, chatID).then((isSuccessful) {
                          if (isSuccessful) {
                            _editingController.clear();
                            _messageListScrollController.animateTo(
                              _messageListScrollController
                                  .position.maxScrollExtent,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.decelerate,
                            );
                          }
                        });
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

class MessageList extends StatelessWidget {
  final ChatViewModel model;
  final Map<String, Message> messages;
  final ScrollController scrollController;

  final String userID;

  MessageList(this.model, this.messages, this.scrollController)
      : userID = model.authState.user.id;

  @override
  Widget build(BuildContext context) {
    final keys = messages.keys.toList();

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        final Message message = messages[keys[index]];
        final fromUser = message.userID == userID;

        return Row(
          mainAxisAlignment:
              fromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: fromUser
                      ? AppColors.primary.withAlpha(-100)
                      : AppColors.light,
                  borderRadius: BorderRadius.only(
                    topLeft: fromUser ? Radius.circular(40) : Radius.zero,
                    topRight: fromUser ? Radius.zero : Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  textDirection:
                      fromUser ? TextDirection.ltr : TextDirection.rtl,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    fromUser
                        ? SmallProfilePicture(
                            model.authState.smallProfilePicture,
                            padding: 0,
                          )
                        : CircleAvatar(),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   '${message.user.firstName} ${message.user.lastName}',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w600,
                          //     color: fromUser ? Colors.white : AppColors.primary,
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            message.text,
                            style: TextStyle(
                              color:
                                  fromUser ? Colors.white : AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            getMonthDayFromInt(message.date),
                            // textAlign: TextAlign.end,
                            textWidthBasis: TextWidthBasis.longestLine,
                            style: TextStyle(
                              color: fromUser ? Colors.white70 : Colors.black54,
                              fontSize:
                                  Theme.of(context).textTheme.caption.fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
