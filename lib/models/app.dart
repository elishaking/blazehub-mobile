import 'package:blazehub/data/user.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/models/profile.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final AuthState authState;
  final PostState postsState;
  final ProfileState profileState;

  AppState({
    @required this.authState,
    @required this.postsState,
    @required this.profileState,
  });

  AppState.initialState()
      : authState = AuthState(
          isAuthenticated: false,
          loading: false,
          user: UserData.user,
          errors: null,
          smallProfilePicture: null,
        ),
        postsState = PostState(
          posts: Map<String, Post>(),
        ),
        profileState = ProfileState(
          profilePicture: null,
          coverPicture: null,
          profileInfo: null,
        );
}
