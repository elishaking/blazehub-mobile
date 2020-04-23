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
              profilePicture: action.payload,
            );

    case SetCoverPicture:
      return state.copyWith(
        coverPicture: (action as SetCoverPicture).payload,
      );

    case SetProfileInfo:
      return state.copyWith(
        profileInfo: (action as SetProfileInfo).payload,
      );

    default:
      return state;
  }
}
