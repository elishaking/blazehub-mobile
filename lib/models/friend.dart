import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class Friend {
  final String name;
  final String username;
  Uint8List profilePicture;

  Friend({
    @required this.name,
    @required this.username,
    this.profilePicture,
  });

  factory Friend.fromJSON(Map json) {
    return Friend(
      name: json['name'],
      username: json['username'],
    );
  }

  Map toJSON() {
    return {
      'name': name,
      'username': username,
    };
  }
}

class FriendState {
  String userID;
  Map<String, Friend> friends;

  FriendState({
    @required this.friends,
    @required this.userID,
  });

  FriendState copyWith({String userID, Map<String, Friend> friends}) {
    if (this.friends == null) this.friends = Map();

    final newFriends = this.friends.map(
          (friendKey, post) => MapEntry(friendKey, post),
        );

    if (friends != null) newFriends.addEntries(friends.entries);

    return FriendState(
      userID: userID ?? this.userID,
      friends: newFriends,
    );
  }

  FriendState replaceWith({String userID, Map<String, Friend> friends}) {
    return FriendState(
      userID: userID ?? this.userID,
      friends: friends ?? this.friends,
    );
  }
}

// class FriendData {
//   final String name;
//   final String username;

//   FriendData({
//     @required this.name,
//     @required this.username,
//   });

//   Map toJSON() {
//     return {
//       'name': name,
//       'username': username,
//     };
//   }
// }
