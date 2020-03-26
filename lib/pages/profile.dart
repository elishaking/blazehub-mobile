import 'package:blazehub/pages/home.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final tabTitles = ['Home', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: Hero(
        tag: 'bottomNav',
        child: BottomNavigationBar(
          onTap: (index) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
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
        ),
      ),
    );
  }
}
