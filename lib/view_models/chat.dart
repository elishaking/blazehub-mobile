import 'package:redux/redux.dart';

import 'package:blazehub/view_models/friend.dart';
import 'package:blazehub/models/app.dart';

class ChatViewModel extends FriendViewModel {
  final Store<AppState> _store;

  ChatViewModel(this._store) : super(_store);

  factory ChatViewModel.create(Store<AppState> store) {
    return ChatViewModel(store);
  }
}
