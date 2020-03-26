import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/profile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return StoreConnector<AppState, ProfileViewModel>(
        converter: (store) => ProfileViewModel.create(store),
        builder: (context, model) {
          final hasProfilePicture = model.profileState.profilePicture != null;
          final hasCoverPicture = model.profileState.coverPicture != null;
          final hasProfile = model.profileState.profileInfo != null;

          if (!hasProfilePicture) {
            model.getProfilePicture(model.authState.user.id);
          }
          if (!hasCoverPicture) {
            model.getCoverPicture(model.authState.user.id);
          }
          if (!hasProfile) {
            model.getProfileInfo(model.authState.user.id);
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
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: hasCoverPicture
                                ? Image.memory(model.profileState.coverPicture)
                                : Container(),
                          ),
                          SizedBox(
                            height: deviceWidth / 4,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: deviceWidth / 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          width: deviceWidth / 2,
                          height: deviceWidth / 2,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(color: Colors.white),
                          // alignment: Alignment.center,
                          child: hasProfilePicture
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(
                                      model.profileState.profilePicture),
                                )
                              : Container(),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${model.authState.user.firstName} ${model.authState.user.lastName}",
                    style: Theme.of(context).textTheme.display1.merge(
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                hasProfile
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.book),
                              title: Text(model.profileState.profileInfo.bio),
                            ),
                          ],
                        ),
                      )
                    : Container(),
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
