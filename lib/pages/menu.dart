import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/pages/add_friend.dart';
import 'package:blazehub/pages/bookmarks.dart';
import 'package:blazehub/pages/profile.dart';
// import 'package:blazehub/view_models/menu.dart';
import 'package:blazehub/view_models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
        converter: (store) => ProfileViewModel.create(store),
        builder: (context, model) {
          final hasSmallProfilePicture =
              model.authState.smallProfilePicture != null;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Menu'),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: SmallProfilePicture(
                    model.authState.smallProfilePicture,
                    SmallProfilePicture.AUTH_USER,
                  ),
                  title: Text(
                      '${model.authState.user.firstName} ${model.authState.user.lastName}'),
                  subtitle: Text('View Profile'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text("Add Friend"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddFriend(model)));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text("Bookmarks"),
                  onTap: () {
                    model.resetPosts();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Bookmarks()));
                  },
                ),
                Divider(),
              ],
            ),
          );
        });
  }
}
