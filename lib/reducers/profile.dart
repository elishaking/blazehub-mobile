import 'package:blazehub/actions/profile.dart';
import 'package:blazehub/models/profile.dart';

ProfileState profileReducer(ProfileState state, action) {
  switch (action.runtimeType) {
    case SetProfilePicture:
      return state.copyWith(
        profilePicture: (action as SetProfilePicture).payload,
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
