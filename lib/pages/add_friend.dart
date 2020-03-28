import 'package:blazehub/components/BorderContainer.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/values/colors.dart';
import 'package:blazehub/view_models/friend.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatefulWidget {
  final FriendViewModel model;

  const AddFriend(this.model);

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  Map<String, AuthUser> users = Map();

  @override
  Widget build(BuildContext context) {
    final userKeys = users.keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: Icon(Icons.person_add),
        title: Text("Add Friend"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        children: <Widget>[
          Form(
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.person_add),
                hintText: "Search name",
                filled: true,
                fillColor: AppColors.light,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged: (text) {
                print(text);
                widget.model.findUsersWithName(text).then((users) {
                  setState(() {
                    this.users = users;
                  });
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BorderContainer(
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[userKeys[index]].firstName),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: users.length,
            ),
          )
        ],
      ),
    );
  }
}
