import 'package:blazehub/models/auth.dart';
import 'package:flutter/foundation.dart';

class Post {
  String id;
  String text;
  int date;
  bool imageUrl;
  bool isBookmarked;
  AuthUser user;
  dynamic likes;
  dynamic comments;

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
}

class PostState {
  Map<String, Post> posts;

  PostState({@required this.posts});

  PostState.initialState(Map<String, Post> posts)
      : posts = Map.unmodifiable(posts);
}
