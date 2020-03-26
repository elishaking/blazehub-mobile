import 'dart:convert';

import 'package:blazehub/containers/comments.dart';
import 'package:blazehub/containers/image_view.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/utils/date.dart';
import 'package:blazehub/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/home.dart';

class _Post {
  String text;

  _Post({this.text});
}

class Home extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _post = _Post();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (Store<AppState> store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('BlazeHub'),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            children: <Widget>[
              CreatePostForm(formKey: _formKey, post: _post),
              SizedBox(
                height: 20,
              ),
              ..._buildPosts(model),
            ],
          ),
        );
      },
    );
  }

  List<PostWidget> _buildPosts(HomeViewModel model) {
    model.listenForNewPosts();

    final posts = model.postsState.posts;

    if (posts == null) return [];

    final List<PostWidget> postsWidget = [];

    posts.forEach((postKey, post) {
      postsWidget.add(
        PostWidget(post, model),
      );
    });
    return postsWidget;
  }
}

class PostWidget extends StatefulWidget {
  const PostWidget(
    this.post,
    this.model, {
    Key key,
  }) : super(key: key);

  final Post post;
  final HomeViewModel model;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  UriData _postImage;

  @override
  void initState() {
    widget.model.getPostImage(widget.post.id).then((image) {
      if (image != null) {
        setState(() {
          _postImage = Uri.parse(image).data;
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
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              '${widget.post.user.firstName} ${widget.post.user.lastName}',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(getMonthDayFromInt(widget.post.date)),
          ),
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
          // SizedBox(
          //   height: 20,
          // ),
          _postImage == null
              ? Container()
              : Container(
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
                            ImageView(_postImage),
                        fullscreenDialog: true,
                      ));
                    },
                    child: Image.memory(
                      _postImage.contentAsBytes(),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Padding(
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
                  color: widget.post.comments[
                              widget.model.authState.user.firstName] ==
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
                IconButton(
                  color: widget.post.isBookmarked
                      ? AppColors.primary
                      : Colors.grey,
                  icon: Icon(
                    Icons.bookmark,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CreatePostForm extends StatelessWidget {
  const CreatePostForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required _Post post,
  })  : _formKey = formKey,
        _post = post,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final _Post _post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.light,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
                bottom: Radius.circular(0),
              ),
            ),
            child: Text(
              "Create Post",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  minLines: 4,
                  maxLines: 7,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Share your thoughts",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                  ),
                  onSaved: (String text) {
                    _post.text = text;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        child: Text('Post'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
