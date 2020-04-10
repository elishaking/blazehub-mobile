import 'dart:io';
import 'dart:convert';

import 'package:blazehub/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:blazehub/components/BottomNav.dart';
import 'package:blazehub/components/PostWidget.dart';
import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:blazehub/models/posts.dart';
import 'package:blazehub/pages/profile.dart';
import 'package:blazehub/values/colors.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/home.dart';

class _Post {
  String text;

  _Post({this.text});
}

class Home extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _post = _Post();

  final tabTitles = ['Home', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (Store<AppState> store) => HomeViewModel.create(store),
      builder: (BuildContext context, HomeViewModel model) {
        final hasSmallProfilePicture =
            model.authState.smallProfilePicture != null;

        if (!hasSmallProfilePicture)
          model.getSmallProfilePicture(model.authState.user.id);

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: hasSmallProfilePicture
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Profile(),
                      ));
                    },
                    child: SmallProfilePicture(
                      model.authState.smallProfilePicture,
                      SmallProfilePicture.AUTH_USER,
                    ),
                  )
                : Icon(Icons.person),
            title: Text('BlazeHub'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Menu()));
                },
              )
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            children: <Widget>[
              CreatePostForm(model),
              SizedBox(
                height: 20,
              ),
              ..._buildPosts(model),
            ],
          ),
          bottomNavigationBar: Hero(
            tag: 'bottomNav',
            child: BottomNav(0),
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

class CreatePostForm extends StatefulWidget {
  final HomeViewModel model;

  const CreatePostForm(this.model);

  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _postTextController = TextEditingController();
  String _postText;
  File _postImage;
  bool _loading = false;

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
                  controller: _postTextController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.subject),
                    hintText: "Share your thoughts",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                  ),
                  validator: (text) {
                    if (text.isEmpty) return '';
                  },
                  onSaved: (String text) {
                    _postText = text;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _postImage == null
                    ? Container()
                    : Stack(
                        children: <Widget>[
                          Image.file(_postImage),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.black45,
                              child: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _postImage = null;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          _openImagePicker(context);
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      _loading
                          ? Spinner()
                          : RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    _loading = true;
                                  });

                                  final hasImage = _postImage != null;

                                  final post = Post(
                                    id: null,
                                    text: _postText,
                                    date: 1000000000000000 -
                                        DateTime.now().millisecondsSinceEpoch,
                                    imageUrl: hasImage,
                                    isBookmarked: false,
                                    user: widget.model.authState.user,
                                  );

                                  String postImageID;

                                  if (hasImage) {
                                    final result = await FlutterImageCompress
                                        .compressWithFile(
                                      _postImage.path,
                                      quality: 50,
                                    );

                                    final postImageDataURL =
                                        'data:image/png;base64,' +
                                            Base64Encoder().convert(result);

                                    postImageID = await widget.model
                                        .uploadPostImage(postImageDataURL);
                                  }

                                  widget.model
                                      .createPost(post, postID: postImageID)
                                      .then((isSuccessful) {
                                    setState(() {
                                      _postTextController.clear();
                                      _postImage = null;
                                      _loading = false;
                                    });
                                  });
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

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400).then((File image) {
      setState(() {
        _postImage = image;
        // print(_postImage.path);
      });

      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 230,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Text('Add Image'),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Use Camera'),
                onTap: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              SizedBox(
                width: 5,
              ),
              ListTile(
                leading: Icon(Icons.picture_in_picture),
                title: Text('Select from Gallery'),
                onTap: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.model.cancelPostListener();
    widget.model.cancelCommentListener();

    super.dispose();
  }
}
