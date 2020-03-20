import 'package:blazehub/actions/auth.dart';
import 'package:blazehub/services/auth.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

class SigninViewModel {
  final AuthState authState;
  Store<AppState> _store;

  SigninViewModel(store, {this.authState}) : _store = store;

  factory SigninViewModel.create(Store<AppState> store) {
    return SigninViewModel(
      store,
      authState: store.state.authState,
    );
  }

  Future<bool> signinUser(UserSigninData userData) async {
    final user = await authService.signinWithEmail(userData);

    if (user == null) return false;

    _store.dispatch(SetCurrentUser(user));

    return true;
  }
}
