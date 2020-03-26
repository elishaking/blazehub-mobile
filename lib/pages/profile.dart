import 'package:blazehub/components/BottomNav.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: Text('John Doe'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  // child: Image.memory(bytes),
                  )
            ],
          )
        ],
      ),
      bottomNavigationBar: Hero(
        tag: 'bottomNav',
        child: BottomNav(1),
      ),
    );
  }
}
