import 'package:blazehub/components/BottomNav.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Menu"),
      ),
      bottomNavigationBar: Hero(
        tag: 'bottomNav',
        child: BottomNav(2),
      ),
    );
  }
}
