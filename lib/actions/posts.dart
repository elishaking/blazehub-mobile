import 'package:blazehub/models/posts.dart';

class SetPosts {
  final Map<String, Post> payload;

  SetPosts(this.payload);
}

class SetPost {
  final Map<String, Post> payload;

  SetPost(this.payload);
}

class UpdatePost {
  final Post payload;

  UpdatePost(this.payload);
}
