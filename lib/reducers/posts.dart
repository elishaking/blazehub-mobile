import 'package:blazehub/actions/posts.dart';
import 'package:blazehub/models/posts.dart';

PostState postsReducer(PostState postState, action) {
  switch (action.runtimeType) {
    case SetPosts:
      return postState.copyWith(
        posts: (action as SetPosts).payload,
      );

    default:
      return postState;
  }
}
