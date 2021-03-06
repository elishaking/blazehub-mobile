import 'package:blazehub/models/auth.dart';
import 'package:blazehub/pages/landing.dart';
import 'package:blazehub/utils/errors.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/signin.dart';

class Signin extends StatelessWidget {
  final userData = UserSigninData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlazeHub"),
      ),
      body: StoreConnector<AppState, SigninViewModel>(
        converter: (Store<AppState> store) => SigninViewModel.create(store),
        builder: (BuildContext context, SigninViewModel model) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "email",
                      ),
                      onSaved: (String newText) {
                        userData.email = newText;
                      },
                      validator: (String text) {
                        if (text.isEmpty)
                          return requiredFieldError('email');
                        else if (!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$')
                            .hasMatch(text.toLowerCase())) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "password",
                      ),
                      onSaved: (String newText) {
                        userData.password = newText;
                      },
                      validator: (String text) {
                        if (text.isEmpty) return requiredFieldError('password');

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    model.authState.loading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            child: Text('Sign Up'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                try {
                                  final signedUp =
                                      await model.signinUser(userData);
                                  print(signedUp);
                                } catch (err) {
                                  print(err);
                                }
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Landing(),
                        ));
                      },
                      child: Text('Sign Up'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SigninButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SigninViewModel model;
  final UserSigninData userData;

  SigninButton(this.model, this.formKey, this.userData);

  @override
  _SigninButtonState createState() => _SigninButtonState();
}

class _SigninButtonState extends State<SigninButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text('Sign Up'),
            onPressed: () async {
              if (widget.formKey.currentState.validate()) {
                widget.formKey.currentState.save();

                setState(() {
                  _loading = true;
                });

                try {
                  final signedUp =
                      await widget.model.signinUser(widget.userData);
                  print(signedUp);
                } catch (err) {
                  print(err);
                }

                setState(() {
                  _loading = false;
                });
              }
            },
          );
  }
}
