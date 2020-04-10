import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/models/friend.dart';
import 'package:blazehub/view_models/friend.dart';
import 'package:flutter/material.dart';

class FriendWidget extends StatelessWidget {
  FriendWidget(this.model, this.friendKey, {this.onTap})
      : friend = model.friendState.friends[friendKey];

  final String friendKey;
  final FriendViewModel model;
  final Friend friend;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // print(friend.profilePicture);
    return ListTile(
      onTap: onTap,
      leading: friend.profilePicture == null
          ? Icon(Icons.person)
          : SmallProfilePicture(
              friend.profilePicture,
              padding: 0,
            ),
      title: Text(
        friend.name,
      ),
    );
  }
}
