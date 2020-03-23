import 'package:blazehub/models/posts.dart';
import 'package:firebase_database/firebase_database.dart';

class PostsService {
  final _dbRef = FirebaseDatabase().reference();

  Stream<Event> newPostAdded() {
    return _dbRef.child('posts').onChildAdded;
  }

  Future<bool> toggleLike(String postID, String userID, bool liked) async {
    try {
      final toggleLikeRef =
          _dbRef.child('posts').child(postID).child('likes').child(userID);

      if (liked)
        await toggleLikeRef.remove();
      else
        await toggleLikeRef.set(1);

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> addComment(Comment comment, String postID) async {
    try {
      await _dbRef
          .child('posts')
          .child(postID)
          .child('comments')
          .push()
          .set(comment.toJSON());

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}

final PostsService postsService = PostsService();
