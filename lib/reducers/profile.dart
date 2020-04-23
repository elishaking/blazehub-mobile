import 'package:blazehub/actions/profile.dart';
import 'package:blazehub/models/profile.dart';

ProfileState profileReducer(ProfileState state, action) {
  switch (action.runtimeType) {
    case SetProfilePicture:
      final action = (action as SetProfilePicture);

      return action.isAuthUser
          ? state.copyWith(
              profilePicture: action.payload,
            )
          : state.copyWith(
              profilePictureNotAuth: action.payload,
            );

    case SetCoverPicture:
      final action = (action as SetCoverPicture);

      return action.isAuthUser
          ? state.copyWith(
              coverPicture: action.payload,
            )
          : state.copyWith(
              coverPictureNotAuth: action.payload,
            );

    case SetProfileInfo:
      final action = (action as SetProfileInfo);

      return action.isAuthUser
          ? state.copyWith(
              profileInfo: action.payload,
            )
          : state.copyWith(
              profileInfoNothAuth: action.payload,
            );

    default:
      return state;
  }
}
