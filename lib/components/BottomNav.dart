import 'package:blazehub/pages/home.dart';
import 'package:blazehub/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final tabTitles = ['Home', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          if (index == 0)
            return Home();
          else
            return Profile();
        }));
      },
      items: [
        BottomNavigationBarItem(
          title: Text(tabTitles[0]),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text(tabTitles[1]),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
