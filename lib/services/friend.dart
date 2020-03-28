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

  Future<AuthUser> findUsersWithName(String nameQuery) async {
    try {
      final users = _dbRef
          .child('users')
          .orderByChild('firstName')
          .startAt(nameQuery)
          .once();
      print(users);
    } catch (err) {
      print(err);

      return null;
    }
  }
}

final friendService = FriendService();
