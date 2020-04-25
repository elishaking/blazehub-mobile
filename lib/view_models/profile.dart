import 'dart:typed_data';

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

  Future<bool> getProfilePicture(
    String userID, {
    bool isAuthUser = true,
  }) async {
    final profilePicture = await profileService.getProfilePicture(userID);

    if (profilePicture == null) return false;

    _store.dispatch(SetProfilePicture(profilePicture, isAuthUser));
    return true;
  }

  Future<bool> getCoverPicture(
    String userID, {
    bool isAuthUser = true,
  }) async {
    final coverPicture = await profileService.getCoverPicture(userID);

    if (coverPicture == null) return false;

    _store.dispatch(SetCoverPicture(coverPicture, isAuthUser));
    return true;
  }

  Future<Uint8List> getFriendProfilePicture(String friendID) async {
    return profileService.getProfilePicture(friendID);
  }

  Future<bool> getProfileInfo(
    String userID, {
    bool isAuthUser = true,
  }) async {
    final profileInfo = await profileService.getProfileInfo(userID);

    if (profileInfo == null) return false;

    _store.dispatch(SetProfileInfo(profileInfo, isAuthUser));
    return true;
  }

  Future<bool> updateProfileInfo(String userID, Profile profileInfo) async {
    final isSuccessful =
        await profileService.updateProfileInfo(userID, profileInfo);

    if (!isSuccessful) return false;

    _store.dispatch(SetProfileInfo(profileInfo, true));
    return true;
  }
}
