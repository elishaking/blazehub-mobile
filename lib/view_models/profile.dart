import 'package:blazehub/actions/profile.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/models/profile.dart';
import 'package:blazehub/services/profile.dart';
import 'package:blazehub/view_models/post.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

class ProfileViewModel extends PostViewModel {
  final AuthState authState;
  final ProfileState profileState;
  final PostState postsState;
  final Store<AppState> _store;

  ProfileViewModel(
    store, {
    this.authState,
    this.profileState,
    this.postsState,
  })  : _store = store,
        super(store);

  factory ProfileViewModel.create(Store<AppState> store) {
    return ProfileViewModel(
      store,
      authState: store.state.authState,
      profileState: store.state.profileState,
      postsState: store.state.postsState,
    );
  }

  Future<bool> getProfilePicture(String userID) async {
    final profilePicture = await profileService.getProfilePicture(userID);

    if (profilePicture == null) return false;

    _store.dispatch(SetProfilePicture(profilePicture));
    return true;
  }

  Future<bool> getCoverPicture(String userID) async {
    final coverPicture = await profileService.getCoverPicture(userID);

    if (coverPicture == null) return false;

    _store.dispatch(SetCoverPicture(coverPicture));
    return true;
  }

  Future<bool> getProfileInfo(String userID) async {
    final profileInfo = await profileService.getProfileInfo(userID);

    if (profileInfo == null) return false;

    _store.dispatch(SetProfileInfo(profileInfo));
    return true;
  }

  Future<bool> updateProfileInfo(String userID, Profile profileInfo) async {
    final isSuccessful =
        await profileService.updateProfileInfo(userID, profileInfo);

    if (!isSuccessful) return false;

    _store.dispatch(SetProfileInfo(profileInfo));
    return true;
  }
}
