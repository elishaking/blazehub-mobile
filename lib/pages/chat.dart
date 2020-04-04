import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/components/FriendWidget.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/pages/chat_message.dart';
import 'package:blazehub/pages/menu.dart';
import 'package:blazehub/view_models/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatViewModel>(
      converter: (store) => ChatViewModel.create(store),
      builder: (context, model) {
        final hasFriends = model.friendState.friends != null;

        if (!hasFriends) {
          model.getFriends(model.authState.user.id);
        }

        final friendKeys = model.friendState.friends.keys.toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Chat'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Menu()));
                },
              )
            ],
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: model.friendState.friends.length,
            itemBuilder: (context, index) {
              return FriendWidget(
                model,
                friendKeys[index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatMessage(),
                  ));
                },
              );
            },
          ),
          bottomNavigationBar: Hero(
            tag: 'bottomNav',
            child: BottomNav(2),
          ),
        );
      },
    );
  }
}
