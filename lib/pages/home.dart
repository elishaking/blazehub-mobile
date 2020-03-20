import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/home.dart';

class _Post {
  String text;

  _Post({this.text});
}

class AppColors {
  static final primary = Color(0xff7c62a9);
  static final light = Color(0xffe7dff1);
}

const months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

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

  List<Container> _buildPosts(HomeViewModel model) {
    if (!HomeViewModel.listeningForNewPosts) model.listenForNewPosts();

    final posts = model.postsState.posts;

    if (posts == null) return [];

    final List<Container> postsWidget = [];

    posts.forEach((postKey, post) {
      final date = DateTime.fromMillisecondsSinceEpoch(post.date);

      postsWidget.add(
        Container(
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
                  '${post.user.firstName} ${post.user.lastName}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('${months[date.month - 1]} ${date.day}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  post.text,
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      );
    });
    return postsWidget;
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
