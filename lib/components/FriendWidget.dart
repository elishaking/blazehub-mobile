import 'package:blazehub/view_models/friend.dart';
import 'package:flutter/material.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget(this.model, this.friendKey);

  final String friendKey;
  final FriendViewModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(Icons.person),
      title: Text(
        model.friendState.friends[friendKey].name,
      ),
    );
  }
}
