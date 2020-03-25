import 'package:blazehub/models/posts.dart';
import 'package:blazehub/utils/date.dart';
import 'package:blazehub/values/colors.dart';
import 'package:blazehub/view_models/home.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final HomeViewModel model;
  final Post post;
  final List<Comment> comments;

  Comments(this.model, Post post)
      : this.post = post,
        comments = List<Comment>();

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  String commentText = '';

  // @override
  // void didUpdateWidget(Comments oldWidget) {
  //   // oldWidget.comments.length != widget.comments.length;

  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    final keys = widget.post.comments.keys.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: widget.model.listenForComments(widget.post.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Loading Comments..."),
              );
            }

            final comment = Comment.fromJSON(snapshot.data.snapshot.value);
            widget.comments.add(comment);

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              itemCount: widget.post.comments.length,
              itemBuilder: (BuildContext context, int index) {
                final Comment comment = widget.post.comments[keys[index]];
                final fromUser =
                    comment.user.id == widget.model.authState.user.id;

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: fromUser
                        ? AppColors.primary.withAlpha(200)
                        : AppColors.light,
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
                          fontSize:
                              Theme.of(context).textTheme.caption.fontSize,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: TextFormField(
            onChanged: (String text) {
              commentText = text;
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
                  if (commentText.isNotEmpty) {
                    final comment = Comment(
                      date: DateTime.now().millisecondsSinceEpoch,
                      text: commentText,
                      user: widget.model.authState.user,
                    );

                    widget.model.addPostComment(comment, widget.post.id);
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
