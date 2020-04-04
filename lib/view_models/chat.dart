import 'package:blazehub/services/chat.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/view_models/friend.dart';
import 'package:blazehub/models/app.dart';

var messageStream;
bool listeningForNewMessages = false;
var messageListener;

class ChatViewModel extends FriendViewModel {
  final Store<AppState> _store;

  ChatViewModel(this._store) : super(_store);

  factory ChatViewModel.create(Store<AppState> store) {
    return ChatViewModel(store);
  }
}
