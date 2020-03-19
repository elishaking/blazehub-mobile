import 'package:blazehub/models/auth.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final AuthState authState;

  AppState({@required this.authState});

  AppState.initialState()
      : authState = AuthState(
          isAuthenticated: false,
          user: null,
          errors: null,
        );
}
