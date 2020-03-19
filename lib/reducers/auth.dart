import 'package:blazehub/actions/auth.dart';
import 'package:blazehub/models/auth.dart';

AuthState authReducer(AuthState authState, action) {
  switch (action.runtimeType) {
    case SetCurrentUser:
      return authState.copyWith(
        user: (action as SetCurrentUser).payload,
      );

    case GetErrors:
      return authState.copyWith(
        errors: (action as GetErrors).payload,
      );

    default:
      return authState;
  }
}
