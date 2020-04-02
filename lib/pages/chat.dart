import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChatViewModel>(
      converter: (store) => ChatViewModel.create(store),
      builder: (context, model) {
        return Center(
          child: Text('Chats'),
        );
      },
    );
  }
}
