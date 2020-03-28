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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: Icon(Icons.person_add),
        title: Text("Add Friend"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
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
                  widget.model.findUsersWithName(text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
