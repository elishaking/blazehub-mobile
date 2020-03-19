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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userData = UserSignupData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlazeHub"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel model) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "first name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (String newText) {
                      userData.firstName = newText;
                    },
                    validator: (String text) {
                      if (text.isEmpty) return requiredFieldError('first name');

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        // model.signupUser(userData.email, userData.password);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String requiredFieldError(String fieldName) => 'Your $fieldName is required';
}

class UserSignupData {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  UserSignupData({this.firstName, this.lastName, this.email, this.password});
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
