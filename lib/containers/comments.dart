import 'package:blazehub/models/posts.dart';
import 'package:blazehub/values/colors.dart';
import 'package:blazehub/view_models/home.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final HomeViewModel model;
  final Post post;

  final _formKey = GlobalKey<FormState>();

  Comments(this.model, Post post, {Key key})
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
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Write a comment',
              filled: true,
              fillColor: AppColors.light,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
