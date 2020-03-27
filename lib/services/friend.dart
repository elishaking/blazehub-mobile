import 'package:firebase_database/firebase_database.dart';

import 'package:blazehub/models/friend.dart';

class FriendService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Future<Map<String, Friend>> getFriends(String userID) async {
    try {
      final friendsSnapshot =
          await _dbRef.child('friends').child(userID).once();

      if (friendsSnapshot.value == null) return null;

      return friendsSnapshot.value.map(
          (friendKey, friend) => MapEntry(friendKey, Friend.fromJSON(friend)));
    } catch (err) {
      print(err);

      return null;
    }
  }
}

final friendService = FriendService();
