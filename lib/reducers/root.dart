import 'package:blazehub/models/app.dart';
import 'package:blazehub/reducers/auth.dart';
import 'package:blazehub/reducers/chat.dart';
import 'package:blazehub/reducers/friend.dart';
import 'package:blazehub/reducers/posts.dart';
import 'package:blazehub/reducers/profile.dart';

/// Root reducer
AppState appStateReducer(AppState state, action) => AppState(
      authState: authReducer(state.authState, action),
      postsState: postsReducer(state.postsState, action),
      profileState: profileReducer(state.profileState, action),
      friendState: friendReducer(state.friendState, action),
      chatState: chatReducer(state.chatState, action),
    );
