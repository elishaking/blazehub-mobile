import 'package:blazehub/components/FriendWidget.dart';
import 'package:blazehub/components/post_widget.dart';
import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:blazehub/containers/edit_profile.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/pages/add_friend.dart';
import 'package:blazehub/pages/menu.dart';
import 'package:blazehub/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/profile.dart';

class Profile extends StatelessWidget {
  const Profile({AuthUser user}) : _user = user;

  final AuthUser _user;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return StoreConnector<AppState, ProfileViewModel>(
        converter: (store) => ProfileViewModel.create(store),
        builder: (context, model) {
          final isAuthUser = _user == null;

          final hasProfilePicture =
              isAuthUser && model.profileState.profilePicture != null;
          final hasCoverPicture =
              isAuthUser && model.profileState.coverPicture != null;
          final hasProfile =
              isAuthUser && model.profileState.profileInfo != null;

          final hasFriends = isAuthUser &&
              model.friendState.userID == model.authState.user.id &&
              model.friendState.friends != null;

          final hasSmallProfilePicture =
              model.authState.smallProfilePicture != null;

          final user = _user ?? model.authState.user;

          if (!hasProfilePicture) {
            model.getProfilePicture(user.id, isAuthUser: isAuthUser);
          }
          if (!hasCoverPicture) {
            model.getCoverPicture(user.id, isAuthUser: isAuthUser);
          }
          if (!hasProfile) {
            model.getProfileInfo(user.id, isAuthUser: isAuthUser);
          }
          if (!hasFriends) {
            model.getFriends(user.id).then((isSuccessful) {
              if (isSuccessful) model.getFriendsWithPictures();
            });
          }

          final profileInfo = isAuthUser
              ? model.profileState.profileInfo
              : model.profileState.profileInfoNothAuth;

          return Scaffold(
            appBar: AppBar(
              leading: hasSmallProfilePicture
                  ? SmallProfilePicture(
                      model.authState.smallProfilePicture,
                      uniqueID: SmallProfilePicture.AUTH_USER,
                      pictureID: model.authState.user.id,
                    )
                  : Icon(Icons.person),
              centerTitle: true,
              title: Text(user.firstName),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Menu()));
                  },
                )
              ],
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: <Widget>[
                hasProfilePicture && hasCoverPicture
                    ? ProfilePictures(model, deviceWidth, isAuthUser)
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Spinner(),
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    hasProfile
                        ? profileInfo.name
                        : "${user.firstName} ${user.lastName}",
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
                _buildProfileInfo(context, model, hasProfile),
                SizedBox(
                  height: 30,
                ),
                _buildFriends(context, model, hasFriends),
                // Text("Posts")
                ..._buildPosts(
                    model, isAuthUser ? model.authState.user.id : _user.id),
              ],
            ),
            bottomNavigationBar: Hero(
              tag: 'bottomNav',
              child: BottomNav(1),
            ),
          );
        });
  }

  Widget _buildProfileInfo(
    BuildContext context,
    ProfileViewModel model,
    bool hasProfile,
  ) {
    if (!hasProfile) return Container();

    final isAuthUser = _user == null;

    final profileInfo = isAuthUser
        ? model.profileState.profileInfo
        : model.profileState.profileInfoNothAuth;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.book),
            title: Text(profileInfo.bio),
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(top: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.location_city),
            title: Text(profileInfo.location),
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(top: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.web),
            title: Text(profileInfo.website),
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(top: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(Icons.date_range),
            title: Text(profileInfo.birth),
          ),
          if (isAuthUser) ...[
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
          ]
        ],
      ),
    );
  }

  List<PostWidget> _buildPosts(ProfileViewModel model, String userID) {
    // TODO: Optimization: create a service method to fetch only the posts created
    // by logged in user
    final posts = model.postsState.posts;

    if (posts == null) return [];

    final List<PostWidget> postsWidget = [];

    posts.forEach((postKey, post) {
      if (post.user.id == userID)
        postsWidget.add(
          PostWidget(
            post,
            model,
            postSource: PostSource.PROFILE,
          ),
        );
    });
    return postsWidget;
  }

  Container _buildFriends(
    BuildContext context,
    ProfileViewModel model,
    bool hasFriends,
  ) {
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
              return FriendWidget(model, friendKeys[index]);
            },
          ),
          Container(
            height: 1,
            color: AppColors.light,
            margin: EdgeInsets.only(bottom: 10),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddFriend(model),
              ));
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

class ProfilePictures extends StatefulWidget {
  final ProfileViewModel model;
  final double deviceWidth;
  final bool isAuthUser;

  const ProfilePictures(this.model, this.deviceWidth, this.isAuthUser);

  @override
  _ProfilePicturesState createState() => _ProfilePicturesState();
}

class _ProfilePicturesState extends State<ProfilePictures> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  widget.isAuthUser
                      ? widget.model.profileState.coverPicture
                      : widget.model.profileState.coverPictureNotAuth,
                ),
              ),
              SizedBox(
                height: widget.deviceWidth / 4,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: widget.deviceWidth / 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Container(
              width: widget.deviceWidth / 2,
              height: widget.deviceWidth / 2,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(color: Colors.white),
              // alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: MemoryImage(
                  widget.isAuthUser
                      ? widget.model.profileState.profilePicture
                      : widget.model.profileState.profilePictureNotAuth,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // TODO: edit cover photo
            },
            mini: true,
            child: Icon(Icons.edit),
            backgroundColor: Colors.black45,
          ),
        ),
        Positioned(
          bottom: 0,
          left: widget.deviceWidth / 2,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // TODO: edit profile photo
            },
            mini: true,
            child: Icon(Icons.edit),
            backgroundColor: Colors.black54,
          ),
        ),
      ],
    );
  }
}
