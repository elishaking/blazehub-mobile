import 'package:blazehub/actions/friend.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/friend.dart';
import 'package:blazehub/services/friend.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

class FriendViewModel {
  final Store<AppState> _store;
  final FriendState friendState;
  final AuthState authState;

  FriendViewModel(this._store)
      : friendState = _store.state.friendState,
        authState = _store.state.authState;

  Future<bool> getFriends(String userID) async {
    final friends = await friendService.getFriends(userID);

    if (friends == null) return false;

    _store.dispatch(SetFriends(friends));
    return true;
  }

  Future<bool> getFriendsWithPictures() async {
    final friends =
        await friendService.getFriendsWithPictures(friendState.friends);

    if (friends == null) return false;

    _store.dispatch(SetFriends(friends));
    return true;
  }

  Future<Map<String, AuthUser>> findUsersWithName(
      String nameQuery, String userID) {
    return friendService.findUsersWithName(nameQuery, userID);
  }

  Future<bool> addFriend(
    String userID,
    String friendUserID,
    Friend friend,
  ) async {
    final isSuccessful =
        await friendService.addFriend(userID, friendUserID, friend);

    if (!isSuccessful) return false;

    final newFriend = {
      friendUserID: Friend(
        name: friend.name,
        username: friend.username,
      ),
    };
    _store.dispatch(SetFriends(newFriend));
    return true;
  }
}
