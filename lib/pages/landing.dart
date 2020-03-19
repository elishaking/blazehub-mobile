import 'package:blazehub/actions/auth.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: Text("hello, world"),
      ),
    );
  }
}

class _ViewModel {
  final AuthState authState;
  final Function signinUser;

  _ViewModel({this.authState, this.signinUser});

  factory _ViewModel.create(Store<AppState> store) {
    _signinUser(email, password) {
      signupUser(email, password)(store.dispatch);
    }

    return _ViewModel(
      authState: store.state.authState,
      signinUser: _signinUser,
    );
  }
}
