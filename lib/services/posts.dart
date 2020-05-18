import 'dart:typed_data';

import 'package:blazehub/models/posts.dart';
import 'package:firebase_database/firebase_database.dart';

class PostsService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Future<bool> createPost(Post post, {String postID}) async {
    try {
      final postRef = postID == null
          ? _dbRef.child('posts').push()
          : _dbRef.child('posts').child(postID);
      await postRef.set(post.toJSON());

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }

  Future<String> uploadPostImage(String imageDataURL) async {
    try {
      final imageRef = _dbRef.child('post-images').push();
      await imageRef.set(imageDataURL);

      return imageRef.key;
    } catch (err) {
      print(err);

      return null;
    }
  }

  Stream<Event> newPostAdded() {
    return _dbRef.child('posts').onChildAdded;
  }

  Future<Map<String, Post>> getPosts() async {
    try {
      final postsSnapshot = await _dbRef.child('posts').limitToLast(10).once();

      final Map data = postsSnapshot.value;

      if (data == null) return null;

      final posts = Map<String, Post>();
      data.forEach((key, post) {
        posts[key] = Post.fromJSON(post)..id = key;
      });

      return posts;
    } catch (err) {
      throw err;
    }
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

  Future<bool> toggleBookmark(
      String postID, String userID, bool isBookmarked) async {
    try {
      final toggleBookmarkRef =
          _dbRef.child('bookmarks').child(userID).child(postID);

      if (isBookmarked) {
        await toggleBookmarkRef.remove();
      } else {
        await toggleBookmarkRef.set(true);
      }

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }

  Future<bool> isPostBookmarked(String postID, String userID) async {
    try {
      final postBookmarkedSnapshot =
          await _dbRef.child('bookmarks').child(userID).child(postID).once();

      return postBookmarkedSnapshot.value == null
          ? false
          : postBookmarkedSnapshot.value;
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

  Stream<Event> newCommentAdded(String postID) {
    return _dbRef.child('posts').child(postID).child('comments').onChildAdded;
  }

  Future<Map<String, Post>> getBookmarks(String userID) async {
    try {
      final bookmarksSnapshot =
          await _dbRef.child('bookmarks').child(userID).once();

      if (bookmarksSnapshot.value == null) return null;

      final bookmarksPostRef = List<Future<DataSnapshot>>();
      bookmarksSnapshot.value.forEach((postKey, post) {
        bookmarksPostRef.add(_dbRef.child('posts').child(postKey).once());
      });

      final bookmarkedPostSnapshots = await Future.wait(bookmarksPostRef);

      final bookmarks = Map<String, Post>();
      bookmarkedPostSnapshots.forEach((bookmarkedPostSnapshot) {
        bookmarks.putIfAbsent(bookmarkedPostSnapshot.key, () {
          final newBookmarkedPost = Post.fromJSON(bookmarkedPostSnapshot.value);
          newBookmarkedPost.id = bookmarkedPostSnapshot.key;
          newBookmarkedPost.isBookmarked = true;

          return newBookmarkedPost;
        });
      });

      return bookmarks;
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<Uint8List> getPostImage(String postID) async {
    try {
      final postImageSnapshot =
          await _dbRef.child('post-images').child(postID).once();

      return Uri.parse(postImageSnapshot.value).data.contentAsBytes();
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<Uint8List> getPostUserImage(String postUserID) async {
    try {
      final postUserImageSnapshot = await _dbRef
          .child('profile-photos')
          .child(postUserID)
          .child('avatar-small')
          .once();

      if (postUserImageSnapshot.value == null) return null;

      return Uri.parse(postUserImageSnapshot.value).data.contentAsBytes();
    } catch (err) {
      print(err);

      return null;
    }
  }
}

final PostsService postsService = PostsService();
