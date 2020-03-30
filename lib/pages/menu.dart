import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/pages/add_friend.dart';
import 'package:blazehub/view_models/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Menu'),
      ),
      body: StoreConnector<AppState, MenuViewModel>(
          converter: (store) => MenuViewModel.create(store),
          builder: (context, model) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text("Add Friend"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddFriend(model)));
                  },
                ),
                Divider()
              ],
            );
          }),
      bottomNavigationBar: Hero(
        tag: 'bottomNav',
        child: BottomNav(2),
      ),
    );
  }
}
