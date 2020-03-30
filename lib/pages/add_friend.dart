import 'package:blazehub/components/BorderContainer.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:blazehub/models/auth.dart';
import 'package:blazehub/models/friend.dart';
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
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged: (text) {
                print(text);
                widget.model
                    .findUsersWithName(text, widget.model.authState.user.id)
                    .then((users) {
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
          this.users.length == 0
              ? Container(
                  height: MediaQuery.of(context).size.height / 2,
                  alignment: Alignment.center,
                  child: Text(
                    "Search for friends",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : BorderContainer(
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final user = users[userKeys[index]];

                      return ListTile(
                        title: Text('${user.firstName} ${user.lastName}'),
                        trailing: AddFriendWidget(
                          widget.model,
                          userKeys[index],
                          user,
                        ),
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

class AddFriendWidget extends StatefulWidget {
  const AddFriendWidget(this.model, this.friendID, this.friend);

  final FriendViewModel model;
  final AuthUser friend;
  final String friendID;

  @override
  _AddFriendWidgetState createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  bool loading = false;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Spinner()
        : isAdded
            ? OutlineButton(
                child: Text('Add'),
                onPressed: null,
              )
            : OutlineButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  final newFriend = Friend(
                    name:
                        '${widget.friend.firstName} ${widget.friend.lastName}',
                    username: widget.friend.username,
                  );

                  widget.model
                      .addFriend(
                    widget.model.authState.user.id,
                    widget.friendID,
                    newFriend,
                  )
                      .then((isSuccessful) {
                    setState(() {
                      loading = false;
                    });
                    if (isSuccessful) {
                      setState(() {
                        isAdded = true;
                      });
                    }
                  });
                },
                child: Text('Add'),
              );
  }
}
