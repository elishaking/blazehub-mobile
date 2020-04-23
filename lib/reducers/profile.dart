import 'package:blazehub/actions/profile.dart';
import 'package:blazehub/models/profile.dart';

ProfileState profileReducer(ProfileState state, action) {
  switch (action.runtimeType) {
    case SetProfilePicture:
      final dispatchedAction = (action as SetProfilePicture);

      return dispatchedAction.isAuthUser
          ? state.copyWith(
              isAuthUser: true,
              profilePicture: dispatchedAction.payload,
            )
          : state.copyWith(
              isAuthUser: false,
              profilePictureNotAuth: dispatchedAction.payload,
            );

    case SetCoverPicture:
      final dispatchedAction = (action as SetCoverPicture);

      return dispatchedAction.isAuthUser
          ? state.copyWith(
              isAuthUser: true,
              coverPicture: dispatchedAction.payload,
            )
          : state.copyWith(
              isAuthUser: false,
              coverPictureNotAuth: dispatchedAction.payload,
            );

    case SetProfileInfo:
      final dispatchedAction = (action as SetProfileInfo);

      return dispatchedAction.isAuthUser
          ? state.copyWith(
              isAuthUser: true,
              profileInfo: dispatchedAction.payload,
            )
          : state.copyWith(
              isAuthUser: false,
              profileInfoNothAuth: dispatchedAction.payload,
            );

    default:
      return state;
  }
}
