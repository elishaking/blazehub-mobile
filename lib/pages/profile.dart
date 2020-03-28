import 'package:blazehub/components/PostWidget.dart';
import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/containers/edit_profile.dart';
import 'package:blazehub/values/colors.dart';
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
          final hasSmallProfilePicture =
              model.authState.smallProfilePicture != null;
          final hasFriends = model.friendState.friends != null;

          if (!hasProfilePicture) {
            model.getProfilePicture(model.authState.user.id);
          }
          if (!hasCoverPicture) {
            model.getCoverPicture(model.authState.user.id);
          }
          if (!hasProfile) {
            model.getProfileInfo(model.authState.user.id);
          }
          if (!hasFriends) {
            model.getFriends(model.authState.user.id);
          }

          return Scaffold(
            appBar: AppBar(
              leading: hasSmallProfilePicture
                  ? SmallProfilePicture(model.authState.smallProfilePicture)
                  : Icon(Icons.person),
              centerTitle: true,
              title: Text(model.authState.user.firstName),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: <Widget>[
                hasProfilePicture && hasCoverPicture
                    ? Stack(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                      model.profileState.coverPicture),
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
                                child: CircleAvatar(
                                  backgroundImage: MemoryImage(
                                      model.profileState.profilePicture),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.light,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    hasProfile
                        ? model.profileState.profileInfo.name
                        : "${model.authState.user.firstName} ${model.authState.user.lastName}",
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.light),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.book),
                              title: Text(model.profileState.profileInfo.bio),
                            ),
                            Container(
                              height: 1,
                              color: AppColors.light,
                              margin: EdgeInsets.only(top: 10),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.location_city),
                              title:
                                  Text(model.profileState.profileInfo.location),
                            ),
                            Container(
                              height: 1,
                              color: AppColors.light,
                              margin: EdgeInsets.only(top: 10),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.web),
                              title:
                                  Text(model.profileState.profileInfo.website),
                            ),
                            Container(
                              height: 1,
                              color: AppColors.light,
                              margin: EdgeInsets.only(top: 10),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.date_range),
                              title: Text(model.profileState.profileInfo.birth),
                            ),
                            Container(
                              height: 1,
                              color: AppColors.light,
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfile(model),
                                  fullscreenDialog: true,
                                ));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text('Edit Profile'),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),

                SizedBox(
                  height: 30,
                ),
                _buildFriends(context, model, hasFriends),
                // Text("Posts")
                ..._buildPosts(model),
              ],
            ),
            bottomNavigationBar: Hero(
              tag: 'bottomNav',
              child: BottomNav(1),
            ),
          );
        });
  }

  List<PostWidget> _buildPosts(ProfileViewModel model) {
    final posts = model.postsState.posts;

    if (posts == null) return [];

    final List<PostWidget> postsWidget = [];

    posts.forEach((postKey, post) {
      postsWidget.add(
        PostWidget(post, model),
      );
    });
    return postsWidget;
  }

  Container _buildFriends(
      BuildContext context, ProfileViewModel model, bool hasFriends) {
    // final friends = model.friendState.friends;

    // if (friends == null) return [];

    // final List<ListTile> friendsWidget = [];

    // friends.forEach((friendKey, friend) {
    //   friendsWidget.add(
    //     ListTile(
    //       leading: Icon(Icons.person),
    //       title: Text(model.friendState.friends[friendKey].name),
    //     ),
    //   );
    // });
    // return friendsWidget;

    if (!hasFriends) return Container();

    final friendKeys = model.friendState.friends.keys.toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.black,
            ),
            title: Text(
              "Friends",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(bottom: 10),
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.light,
              );
            },
            itemCount: model.friendState.friends.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                leading: Icon(Icons.person),
                title: Text(
                  model.friendState.friends[friendKeys[index]].name,
                ),
              );
            },
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(bottom: 10),
          ),
          RaisedButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => AddFriends(model),
              // ));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.person_add),
                SizedBox(
                  width: 16,
                ),
                Text('Add Friend'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
