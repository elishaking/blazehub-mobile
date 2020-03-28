import 'package:flutter/foundation.dart';

class Friend {
  final String name;

  Friend({@required this.name});

  factory Friend.fromJSON(Map json) {
    return Friend(name: json['name']);
  }
}

class FriendState {
  Map<String, Friend> friends;

  FriendState({@required this.friends});

  FriendState copyWith({Map<String, Friend> friends}) {
    if (this.friends == null) this.friends = Map();

    final newFriends = this.friends.map(
          (friendKey, post) => MapEntry(friendKey, post),
        );

    if (friends != null) newFriends.addEntries(friends.entries);

    return FriendState(friends: newFriends);
  }
}

class FriendData {
  final String name;
  final String username;

  FriendData({
    @required this.name,
    @required this.username,
  });

  Map toJSON() {
    return {
      'name': name,
      'username': username,
    };
  }
}
