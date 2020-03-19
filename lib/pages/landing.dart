import 'package:blazehub/actions/auth.dart';
import 'package:blazehub/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/models/auth.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlazeHub"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel model) {
          return Center(
            child: Text("${model.authState.isAuthenticated}"),
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final AuthState authState;
  Store<AppState> _store;

  _ViewModel(store, {this.authState}) : _store = store;

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      store,
      authState: store.state.authState,
    );
  }

  signupUser(String email, String password) async {
    final firebaseUser = await authService.signupWithEmail(email, password);
    final user = AuthUser(
      email: firebaseUser.email,
      username: firebaseUser.displayName,
    );

    _store.dispatch(SetCurrentUser(user));
  }
}
