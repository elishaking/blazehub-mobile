import 'package:blazehub/models/auth.dart';
import 'package:blazehub/pages/signin.dart';
import 'package:blazehub/view_models/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userData = UserSignupData();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlazeHub"),
      ),
      body: StoreConnector<AppState, LandingViewModel>(
        converter: (Store<AppState> store) => LandingViewModel.create(store),
        builder: (BuildContext context, LandingViewModel model) {
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
                        labelText: "first name",
                      ),
                      onSaved: (String newText) {
                        userData.firstName = newText;
                      },
                      validator: (String text) {
                        if (text.isEmpty)
                          return requiredFieldError('first name');

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "last name",
                      ),
                      onSaved: (String newText) {
                        userData.lastName = newText;
                      },
                      validator: (String text) {
                        if (text.isEmpty)
                          return requiredFieldError('last name');

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                    _loading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            child: Text('Sign Up'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                setState(() {
                                  _loading = true;
                                });

                                try {
                                  final signedUp =
                                      await model.signupUser(userData);
                                  print(signedUp);
                                } catch (err) {
                                  print(err);
                                }

                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Signin(),
                        ));
                      },
                      child: Text('Sign In'),
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

  String requiredFieldError(String fieldName) => 'Your $fieldName is required';
}
