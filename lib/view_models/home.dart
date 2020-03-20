import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

class HomeViewModel {
  final AuthState authState;
  final Store<AppState> _store;

  HomeViewModel(Store<AppState> store, {this.authState}) : _store = store;

  factory HomeViewModel.create(Store<AppState> store) {
    return HomeViewModel(
      store,
      authState: store.state.authState,
    );
  }
}
