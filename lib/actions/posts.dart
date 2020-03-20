import 'package:blazehub/models/posts.dart';

class SetPosts {
  final Map<String, Post> payload;

  SetPosts(this.payload);
}

class SetPost {
  final Map<String, Post> payload;

  SetPost(this.payload);
}
