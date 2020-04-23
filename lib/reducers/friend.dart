import 'package:blazehub/actions/friend.dart';
import 'package:blazehub/models/friend.dart';

FriendState friendReducer(FriendState friendState, action) {
  switch (action.runtimeType) {
    case SetFriends:
      final dispatchedAction = (action as SetFriends);
      if (friendState.userID != dispatchedAction.userID)
        return friendState.replaceWith(
          userID: dispatchedAction.userID,
          friends: dispatchedAction.payload,
        );

      return friendState.copyWith(
        friends: dispatchedAction.payload,
      );

    default:
      return friendState;
  }
}
