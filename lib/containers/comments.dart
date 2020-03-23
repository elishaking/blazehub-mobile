import 'package:blazehub/models/posts.dart';
import 'package:blazehub/utils/date.dart';
import 'package:blazehub/values/colors.dart';
import 'package:blazehub/view_models/home.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final HomeViewModel model;
  final Post post;
  final newComment = {'text': ''};

  Comments(this.model, Post post) : this.post = post;

  @override
  Widget build(BuildContext context) {
    final keys = post.comments.keys.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        itemCount: post.comments.length,
        itemBuilder: (BuildContext context, int index) {
          final Comment comment = post.comments[keys[index]];
          final fromUser = comment.user.id == model.authState.user.id;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color:
                  fromUser ? AppColors.primary.withAlpha(200) : AppColors.light,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${comment.user.firstName} ${comment.user.lastName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: fromUser ? Colors.white : AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  comment.text,
                  style: TextStyle(
                    color: fromUser ? Colors.white : AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  getMonthDayFromInt(comment.date),
                  textAlign: TextAlign.end,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: TextStyle(
                    color: fromUser ? Colors.white70 : Colors.black54,
                    fontSize: Theme.of(context).textTheme.caption.fontSize,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: TextFormField(
            onChanged: (String text) {
              newComment['text'] = text;
            },
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
                onPressed: () {
                  if (newComment['text'].isNotEmpty) {
                    final comment = Comment(
                      date: DateTime.now().millisecondsSinceEpoch,
                      text: newComment['text'],
                      user: model.authState.user,
                    );

                    model.addPostComment(comment, post.id);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
