import 'package:blazehub/components/BottomNav.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: Hero(
        tag: 'bottomNav',
        child: BottomNav(1),
      ),
    );
  }
}
