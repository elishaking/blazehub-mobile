import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/posts.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final AuthState authState;
  final PostState postsState;

  AppState({
    @required this.authState,
    @required this.postsState,
  });

  AppState.initialState()
      : authState = AuthState(
          isAuthenticated: false,
          loading: false,
          user: null,
          errors: null,
        ),
        postsState = PostState(
          posts: Map<String, Post>(),
        );
}
