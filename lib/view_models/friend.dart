import 'package:blazehub/actions/friend.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/friend.dart';
import 'package:blazehub/services/friend.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

class FriendViewModel {
  final Store<AppState> _store;
  final FriendState friendState;

  FriendViewModel(this._store) : friendState = _store.state.friendState;

  Future<bool> getFriends(String userID) async {
    final friends = await friendService.getFriends(userID);

    if (friends == null) return false;

    _store.dispatch(SetFriends(friends));
    return true;
  }

  Future<Map<String, AuthUser>> findUsersWithName(String nameQuery) {
    return friendService.findUsersWithName(nameQuery);
  }

  Future<bool> addFriend(
    String userID,
    String friendUserID,
    FriendData friendData,
  ) async {
    final isSuccessful =
        await friendService.addFriend(userID, friendUserID, friendData);

    if (!isSuccessful) return false;

    final newFriend = {
      friendUserID: Friend(name: friendData.name),
    };
    _store.dispatch(SetFriends(newFriend));
    return true;
  }
}
