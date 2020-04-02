import 'dart:typed_data';

import 'package:blazehub/view_models/post.dart';
import 'package:flutter/material.dart';

import 'package:blazehub/containers/comments.dart';
import 'package:blazehub/containers/image_view.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/utils/date.dart';
import 'package:blazehub/values/colors.dart';

class PostWidget extends StatefulWidget {
  const PostWidget(
    this.post,
    this.model, {
    this.shouldDisplayBookmarkButton = true,
    Key key,
  }) : super(key: key);

  final Post post;
  final PostViewModel model;
  final bool shouldDisplayBookmarkButton;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  Uint8List _postImage;
  Uint8List _postUserImage;

  @override
  void initState() {
    widget.model.getPostImage(widget.post.id).then((image) {
      // TODO: reduce number of calls by adding this to redux - saves data
      if (image != null) {
        setState(() {
          _postImage = Uri.parse(image).data.contentAsBytes();
        });
      }
    });

    widget.model.getPostUserImage(widget.post.user.id).then((image) {
      // TODO: reduce number of calls by adding this to redux - saves data
      if (image != null) {
        setState(() {
          _postUserImage = image;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postLiked = widget.post.likes[widget.model.authState.user.id] != null;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPostHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.post.text,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            color: AppColors.light,
          ),
          _buildPostImage(),
          _buildPostActions(postLiked, context)
        ],
      ),
    );
  }

  Container _buildPostImage() {
    if (_postImage == null) return Container();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.light,
          width: 0.3,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                ImageView(_postImage, widget.post.id),
            fullscreenDialog: true,
          ));
        },
        child: Hero(
          tag: widget.post.id,
          child: Image.memory(
            _postImage,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  ListTile _buildPostHeader() {
    return ListTile(
      leading: _postUserImage == null
          ? Icon(Icons.person)
          : CircleAvatar(
              backgroundImage: MemoryImage(_postUserImage),
            ),
      title: Text(
        '${widget.post.user.firstName} ${widget.post.user.lastName}',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(getMonthDayFromInt(widget.post.date)),
    );
  }

  Padding _buildPostActions(bool postLiked, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            color: postLiked ? AppColors.primary : Colors.grey,
            icon: Icon(
              Icons.thumb_up,
              size: 20,
            ),
            onPressed: () {
              widget.model.togglePostLike(
                widget.post.id,
                widget.model.authState.user.id,
                postLiked,
              );
            },
          ),
          Text(widget.post.likes.length.toString()),
          SizedBox(
            width: 21,
          ),
          IconButton(
            color:
                widget.post.comments[widget.model.authState.user.firstName] ==
                        null
                    ? Colors.grey
                    : AppColors.primary,
            icon: Icon(
              Icons.mode_comment,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Comments(widget.model, widget.post),
                fullscreenDialog: true,
              ));
            },
          ),
          Text(widget.post.comments.length.toString()),
          Flexible(
            child: Container(),
          ),
          widget.shouldDisplayBookmarkButton
              ? IconButton(
                  color: widget.post.isBookmarked
                      ? AppColors.primary
                      : Colors.grey,
                  icon: Icon(
                    Icons.bookmark,
                    size: 20,
                  ),
                  onPressed: () {
                    widget.model
                        .togglePostBookmark(
                          widget.post.id,
                          widget.model.authState.user.id,
                          widget.post.isBookmarked,
                        )
                        .then((isSuccessful) => setState(() {}));
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
