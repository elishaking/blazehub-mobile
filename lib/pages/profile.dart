import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/profile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
        converter: (store) => ProfileViewModel.create(store),
        builder: (context, model) {
          final hasProfilePicture = model.profileState.profilePicture != null;

          if (!hasProfilePicture) {
            model.getProfilePicture(model.authState.user.id);
          }

          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.person),
              title: Text(model.authState.user.firstName),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: hasProfilePicture
                          ? Image.memory(model.profileState.profilePicture)
                          : Container(),
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
        });
  }
}
