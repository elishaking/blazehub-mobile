import 'package:blazehub/models/app.dart';
import 'package:blazehub/reducers/auth.dart';
import 'package:blazehub/reducers/posts.dart';

/// Root reducer
AppState appStateReducer(AppState state, action) => AppState(
      authState: authReducer(state.authState, action),
      postsState: postsReducer(state.postsState, action),
    );
