import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:blazehub/pages/home.dart';
import 'package:blazehub/store.dart';
import 'package:blazehub/values/colors.dart';

import 'package:blazehub/pages/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'BlazeHub',
        theme: ThemeData(
          // primarySwatch: Colors.green,
          primaryColor: Color(0xff7c62a9),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff7c62a9),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textTheme: ButtonTextTheme.primary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
        ),
        home: Home(),
      ),
    );
  }
}
