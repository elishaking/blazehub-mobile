import 'package:blazehub/models/posts.dart';

class UpdatePosts {
  final Map<String, Post> payload;

  UpdatePosts(this.payload);
}

class UpdatePost {
  final Post payload;

  UpdatePost(this.payload);
}

class SetPosts {
  final Map<String, Post> payload;

  SetPosts(this.payload);
}
