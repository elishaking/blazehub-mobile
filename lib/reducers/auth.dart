import 'package:blazehub/actions/auth.dart';
import 'package:blazehub/models/auth.dart';

AuthState authReducer(AuthState authState, action) {
  switch (action.runtimeType) {
    case SetCurrentUser:
      return authState.copyWith(
        user: (action as SetCurrentUser).payload,
      );

    case UpdateLoading:
      return authState.copyWith(
        loading: (action as UpdateLoading).payload,
      );

    case GetErrors:
      return authState.copyWith(
        errors: (action as GetErrors).payload,
      );

    case SetSmallProfilePicture:
      return authState.copyWith(
        smallProfilePicture: (action as SetSmallProfilePicture).payload,
      );

    default:
      return authState;
  }
}
