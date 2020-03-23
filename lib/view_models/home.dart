import 'package:blazehub/actions/posts.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/services/posts.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

final postListener = postsService.newPostAdded();

class HomeViewModel {
  final AuthState authState;
  final PostState postsState;
  final Store<AppState> _store;

  // static bool listeningForNewPosts = false;

  HomeViewModel(Store<AppState> store, {this.authState, this.postsState})
      : _store = store;

  factory HomeViewModel.create(Store<AppState> store) {
    return HomeViewModel(
      store,
      authState: store.state.authState,
      postsState: store.state.postsState,
    );
  }

  void listenForNewPosts() {
    // TODO: dispose this stream
    postListener.listen((onData) {
      // print(onData.snapshot.value);
      final newPostData = onData.snapshot.value;
      newPostData['id'] = onData.snapshot.key;

      final newPost = Post.fromJSON(newPostData);

      _store.dispatch(SetPosts({newPost.id: newPost}));
      print(_store.state.postsState.posts.keys.length);
    });

    // listeningForNewPosts = true;
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

  Future<bool> addPostComment(Comment comment, String postID) async {
    return await postsService.addComment(comment, postID);
  }
}
