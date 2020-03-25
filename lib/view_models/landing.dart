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

  Future<bool> signupUser(UserSignupData userData) async {
    _store.dispatch(UpdateLoading(true));
    bool isSuccessful = true;

    final user = await authService.signupWithEmail(userData);

    if (user == null) isSuccessful = false;

    // TODO: replace this dispatch with getErrors onFail
    _store.dispatch(SetCurrentUser(user));
    _store.dispatch(UpdateLoading(false));

    return isSuccessful;
  }
}
