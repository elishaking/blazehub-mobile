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

  Future<Map<String, Friend>> getFriendsWithPictures(
      Map<String, Friend> friends) async {
    try {
      final friendPictureRefs = List<Future<DataSnapshot>>();

      friends.forEach((friendKey, friend) {
        friendPictureRefs.add(_dbRef
            .child('profile-photos')
            .child(friendKey)
            .child('avatar-small')
            .once());
      });

      final friendPictureSnapshots = await Future.wait(friendPictureRefs);

      friendPictureSnapshots.forEach((friendPictureSnapshot) {
        friends.update(
          friendPictureSnapshot.key,
          (friend) => friend..profilePicture = friendPictureSnapshot.value,
        );
      });

      return friends;
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<Map<String, AuthUser>> findUsersWithName(
      String nameQuery, String userID) async {
    final nameQueryWords = nameQuery.split(" ");
    String fullQuery = '';
    nameQueryWords.forEach((query) {
      fullQuery += '${query.replaceFirst(query[0], query[0].toUpperCase())} ';
    });

    fullQuery = fullQuery.trim();
    print(fullQuery);

    try {
      final usersSnapshot = await _dbRef
          .child('users')
          .orderByChild('firstName')
          .startAt(fullQuery)
          .endAt(fullQuery + "\uf8ff")
          .once();
      final users = usersSnapshot.value;

      final friendsSnapshot =
          await _dbRef.child('friends').child(userID).once();
      final friends = friendsSnapshot.value;

      final Map<String, AuthUser> potentialFriends = Map();

      users.forEach((userKey, user) {
        if (friends[userKey] == null)
          potentialFriends.putIfAbsent(userKey, () => AuthUser.fromJSON(user));
      });

      return potentialFriends;
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
