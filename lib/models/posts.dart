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
      comments: json['comments'] == null
          ? Map<dynamic, dynamic>()
          : Comment.fromMap(json['comments']),
    );
  }
}

class PostState {
  Map<String, Post> posts;

  PostState({@required this.posts});

  PostState copyWith({Map<String, Post> posts}) {
    final newPosts = this.posts.map(
          (postKey, post) => MapEntry(postKey, post),
        );

    if (posts != null) newPosts.addEntries(posts.entries);

    return PostState(posts: newPosts);
  }
}

class Comment {
  final int date;
  final String text;
  final AuthUser user;

  Comment({
    @required this.date,
    @required this.text,
    @required this.user,
  });

  factory Comment.fromJSON(Map<dynamic, dynamic> json) {
    return Comment(
      date: json['date'],
      text: json['text'],
      user: AuthUser.fromJSON(json['user']),
    );
  }

  static Map<dynamic, Comment> fromMap(Map<dynamic, dynamic> json) {
    final comments = Map<dynamic, Comment>();

    json.keys.forEach((commentKey) {
      comments.putIfAbsent(
        commentKey,
        () => Comment.fromJSON(json[commentKey]),
      );
    });

    return comments;
  }

  Map<dynamic, dynamic> toJSON() {
    return {
      'text': text,
      'date': date,
      'user': user.toJSON(),
    };
  }
}
