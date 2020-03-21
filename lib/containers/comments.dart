import 'package:blazehub/models/posts.dart';
import 'package:blazehub/view_models/home.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final HomeViewModel model;
  final Post post;

  const Comments(this.model, Post post, {Key key})
      : this.post = post,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: post.comments.length,
        itemBuilder: (BuildContext context, int count) {
          return Container();
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Write a comment',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
