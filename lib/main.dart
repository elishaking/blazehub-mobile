import 'package:blazehub/models/app.dart';
import 'package:blazehub/reducers/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/pages/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'BlazeHub',
        theme: ThemeData(
          // primarySwatch: Colors.green,
          primaryColor: Color(0xff7c62a9),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff7c62a9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Landing(),
      ),
    );
  }
}
