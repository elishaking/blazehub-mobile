import 'package:blazehub/pages/home.dart';

class SetPosts {
  final Map<String, dynamic> payload;

  SetPosts(this.payload);
}

class SetPost {
  final Map<String, Post> payload;

  SetPost(this.payload);
}
