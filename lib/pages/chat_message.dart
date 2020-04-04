import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/chat.dart';

class ChatMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => ChatViewModel.create(store),
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Messages'),
          ),
        );
      },
    );
  }
}
