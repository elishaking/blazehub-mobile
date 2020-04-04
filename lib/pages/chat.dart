import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/models/app.dart';
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
            itemCount: 0,
            itemBuilder: (context, index) {
              return Container();
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
