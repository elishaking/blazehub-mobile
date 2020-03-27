import 'package:blazehub/actions/friend.dart';
import 'package:blazehub/services/friend.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

class FriendViewModel {
  final Store<AppState> _store;

  FriendViewModel(this._store);

  Future<bool> getFriends(String userID) async {
    final friends = await friendService.getFriends(userID);

    if (friends == null) return false;

    _store.dispatch(SetFriends(friends));
    return true;
  }
}
