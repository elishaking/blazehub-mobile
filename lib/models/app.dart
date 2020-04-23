import 'package:blazehub/data/user.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/chat.dart';
import 'package:blazehub/models/friend.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/models/profile.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final AuthState authState;
  final PostState postsState;
  final ProfileState profileState;
  final FriendState friendState;
  final ChatState chatState;

  AppState({
    @required this.authState,
    @required this.postsState,
    @required this.profileState,
    @required this.friendState,
    @required this.chatState,
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
          profilePictureNotAuth: null,
          coverPicture: null,
          profileInfo: null,
        ),
        friendState = FriendState(
          friends: null,
        ),
        chatState = ChatState(
          chats: null,
        );
}
