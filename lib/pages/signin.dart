import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/signin.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlazeHub"),
      ),
      body: StoreConnector<AppState, SigninViewModel>(
        converter: (Store<AppState> store) => SigninViewModel.create(store),
        builder: (BuildContext context, SigninViewModel model) {
          return Center(child: Text("hello"));
        },
      ),
    );
  }
}
