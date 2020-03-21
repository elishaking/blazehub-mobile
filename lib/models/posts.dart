import 'package:blazehub/models/auth.dart';
import 'package:flutter/foundation.dart';

class Post {
  String id;
  String text;
  int date;
  bool imageUrl;
  bool isBookmarked;
  AuthUser user;
  Map<dynamic, dynamic> likes;
  Map<dynamic, dynamic> comments;

  Post({
    @required this.id,
    @required this.text,
    @required this.date,
    @required this.imageUrl,
    @required this.isBookmarked,
    this.user,
    this.likes,
    this.comments,
  });

  factory Post.fromJSON(Map<dynamic, dynamic> json) {
    return Post(
      id: json['id'],
      text: json['text'],
      date: json['date'],
      imageUrl:
          json['imageUrl'].runtimeType == String ? false : json['imageUrl'],
      isBookmarked: json['isBookmarked'] ?? false,
      user: AuthUser.fromJSON(json['user']),
      likes: json['likes'] ?? Map<dynamic, dynamic>(),
      comments: json['comments'] ?? Map<dynamic, dynamic>(),
    );
  }
}

class PostState {
  Map<String, Post> posts;

  PostState({@required this.posts});

  PostState copyWith({Map<String, Post> posts}) {
    final newPosts = this.posts.map(
          (postKey, post) => MapEntry(postKey, post),
        )..addEntries(posts.entries);

    return PostState(posts: newPosts);
  }
}
