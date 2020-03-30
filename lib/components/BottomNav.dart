import 'package:blazehub/pages/Menu.dart';
import 'package:blazehub/pages/home.dart';
import 'package:blazehub/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          if (index == 0)
            return Home();
          else if (index == 1)
            return Profile();
          else
            return Menu();
        }));
      },
      items: [
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('Profile'),
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          title: Text('Menu'),
          icon: Icon(Icons.menu),
        ),
      ],
    );
  }
}
