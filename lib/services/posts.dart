import 'package:firebase_database/firebase_database.dart';

class PostsService {
  final _dbRef = FirebaseDatabase().reference();

  Stream<Event> newPostAdded() {
    return _dbRef.child('posts').onChildAdded;
  }

  Future<bool> togglePostLike(String postID, String userID, bool liked) async {
    try {
      final togglePostLikeRef =
          _dbRef.child('posts').child(postID).child('likes').child(userID);

      if (liked)
        await togglePostLikeRef.remove();
      else
        await togglePostLikeRef.set(1);

      return true;
    } catch (err) {
      return false;
    }
  }
}

final PostsService postsService = PostsService();
