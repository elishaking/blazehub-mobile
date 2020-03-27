import 'package:blazehub/actions/friend.dart';
import 'package:blazehub/models/friend.dart';

FriendState friendReducer(FriendState friendState, action) {
  switch (action.runtimeType) {
    case SetFriends:
      return friendState.copyWith(
        friends: (action as SetFriends).payload,
      );

    default:
      return friendState;
  }
}
