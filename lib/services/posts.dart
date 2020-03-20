import 'package:firebase_database/firebase_database.dart';

class PostsService {
  final _dbRef = FirebaseDatabase().reference();

  Stream<Event> newPostAdded() {
    return _dbRef.child('posts').onChildAdded;
  }
}

final PostsService postsService = PostsService();
