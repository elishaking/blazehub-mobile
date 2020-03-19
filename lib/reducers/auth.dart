import 'package:blazehub/models/auth.dart';

AuthState authReducer(AuthState authState, action) {
  switch (action.runtimeType.toString()) {
    case "":
      return authState;

    default:
      return authState;
  }
}
