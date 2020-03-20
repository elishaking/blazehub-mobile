import 'package:blazehub/actions/auth.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/services/auth.dart';
import 'package:redux/redux.dart';

class LandingViewModel {
  final AuthState authState;
  Store<AppState> _store;

  LandingViewModel(store, {this.authState}) : _store = store;

  factory LandingViewModel.create(Store<AppState> store) {
    return LandingViewModel(
      store,
      authState: store.state.authState,
    );
  }

  Future<bool> signupUser(String email, String password) async {
    final firebaseUser = await authService.signupWithEmail(email, password);

    if (firebaseUser == null) return false;

    final user = AuthUser(
      email: firebaseUser.email,
      username: firebaseUser.displayName,
    );

    _store.dispatch(SetCurrentUser(user));

    return true;
  }
}
