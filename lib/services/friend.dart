import 'package:blazehub/models/auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:blazehub/models/friend.dart';

class FriendService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Future<Map<String, Friend>> getFriends(String userID) async {
    try {
      final friendsSnapshot =
          await _dbRef.child('friends').child(userID).once();

      if (friendsSnapshot.value == null) return null;

      final Map<String, Friend> friends = Map();

      friendsSnapshot.value.forEach(
        (friendKey, friend) => {
          friends.putIfAbsent(friendKey, () => Friend.fromJSON(friend)),
        },
      );

      return friends;
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<Map<String, AuthUser>> findUsersWithName(String nameQuery) async {
    try {
      final usersSnapshot = await _dbRef
          .child('users')
          .orderByChild('firstName')
          .startAt(nameQuery)
          .endAt(nameQuery + "\uf8ff")
          .once();

      final Map<String, AuthUser> users = Map();

      usersSnapshot.value.forEach((userKey, user) {
        users.putIfAbsent(userKey, () => AuthUser.fromJSON(user));
      });

      return users;
    } catch (err) {
      print(err);

      return Map();
    }
  }

  Future<bool> addFriend(
    String userID,
    String friendUserID,
    Friend friend,
  ) async {
    try {
      _dbRef
          .child('friends')
          .child(userID)
          .child(friendUserID)
          .set(friend.toJSON());

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }
}

final friendService = FriendService();
