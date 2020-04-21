import 'dart:typed_data';

import 'package:blazehub/actions/posts.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/services/posts.dart';
import 'package:blazehub/view_models/friend.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

final postStream = postsService.newPostAdded();
bool listeningForNewPosts = false;
var postListener;

bool listeningForNewComments = false;
var commentListener;

class PostViewModel extends FriendViewModel {
  final Store<AppState> _store;
  final AuthState authState;
  final PostState postsState;

  Stream postCommentsStream;

  PostViewModel(this._store)
      : this.authState = _store.state.authState,
        this.postsState = _store.state.postsState,
        super(_store);

  Future<bool> createPost(Post post, {String postID}) {
    return postsService.createPost(post, postID: postID);
  }

  Future<String> uploadPostImage(String imageDataURL) {
    return postsService.uploadPostImage(imageDataURL);
  }

  void listenForNewPosts() {
    // TODO: dispose this stream
    if (listeningForNewPosts) return;

    postListener = postStream.listen((onData) async {
      // print(onData.snapshot.value);
      final newPostData = onData.snapshot.value;
      newPostData['id'] = onData.snapshot.key;

      final postBookmarked = await postsService.isPostBookmarked(
          onData.snapshot.key, authState.user.id);
      newPostData['isBookmarked'] = postBookmarked;

      final newPost = Post.fromJSON(newPostData);

      _store.dispatch(UpdatePosts({newPost.id: newPost}));
      // print(_store.state.postsState.posts);
      // print(_store.state.postsState.posts.keys.length);
    });

    listeningForNewPosts = true;
  }

  void cancelPostListener() {
    if (listeningForNewPosts) {
      postListener.cancel();

      listeningForNewPosts = false;
    }
  }

  Stream listenForComments(String postID) {
    if (listeningForNewComments) return postCommentsStream;

    postCommentsStream = postsService.newCommentAdded(postID);
    commentListener = postCommentsStream.listen((onData) {
      final newComment = Comment.fromJSON(onData.snapshot.value);

      final newPost = _store.state.postsState.posts[postID];
      newPost.comments.putIfAbsent(onData.snapshot.key, () => newComment);

      _store.dispatch(UpdatePost(newPost));
      print(_store.state.postsState.posts[postID].comments.keys.length);
    });

    listeningForNewComments = true;

    return postCommentsStream;
  }

  void cancelCommentListener() {
    if (listeningForNewComments) {
      commentListener.cancel();

      listeningForNewComments = false;
    }
  }

  Future<bool> togglePostLike(String postID, String userID, bool liked) async {
    final isSuccessful = await postsService.toggleLike(postID, userID, liked);

    if (isSuccessful) {
      final newPost = _store.state.postsState.posts[postID];
      if (liked)
        newPost.likes.remove(userID);
      else
        newPost.likes.putIfAbsent(userID, () => 1);

      _store.dispatch(UpdatePost(newPost));

      return true;
    }

    return false;
  }

  Future<bool> togglePostBookmark(
      String postID, String userID, bool isBookmarked) async {
    final isSuccessful =
        await postsService.toggleBookmark(postID, userID, isBookmarked);

    if (isSuccessful) {
      final newPost = _store.state.postsState.posts[postID];
      newPost.isBookmarked = !isBookmarked;

      _store.dispatch(UpdatePost(newPost));

      return true;
    }

    return false;
  }

  Future<bool> addPostComment(Comment comment, String postID) async {
    return await postsService.addComment(comment, postID);
  }

  Future<bool> getBookmarks(String userID) async {
    final bookmarks = await postsService.getBookmarks(userID);
    if (bookmarks == null) return false;

    _store.dispatch(SetPosts(bookmarks));

    return true;
  }

  Future<String> getPostImage(String postID) async {
    return await postsService.getPostImage(postID);
  }

  Future<Uint8List> getPostUserImage(String postUserID) {
    return postsService.getPostUserImage(postUserID);
  }

  void resetPosts() {
    _store.dispatch(SetPosts(null));
  }
}
