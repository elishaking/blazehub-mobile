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

  getCoverPhoto(String userID) {}
}
