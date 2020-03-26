import 'dart:typed_data';

import 'package:blazehub/services/profile.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

class ProfileViewModel {
  final AuthState authState;
  final Store<AppState> _store;

  ProfileViewModel(store, {this.authState}) : _store = store;

  factory ProfileViewModel.create(Store<AppState> store) {
    return ProfileViewModel(
      store,
      authState: store.state.authState,
    );
  }

  Future<Uint8List> getCoverPhoto(String userID) async {
    return await profileService.getProfilePicture(userID);
  }
}
