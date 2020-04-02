import 'package:blazehub/components/PostWidget.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/post.dart';

bool retrievedBookmarks = false;

class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostViewModel>(
      converter: (Store<AppState> store) => PostViewModel(store),
      builder: (context, model) {
        if (!retrievedBookmarks) {
          model.getBookmarks(model.authState.user.id);
          retrievedBookmarks = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Bookmarks'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: _buildBookmarks(model),
          ),
        );
      },
    );
  }

  Widget _buildBookmarks(PostViewModel model) {
    if (!retrievedBookmarks)
      return Center(
        child: Spinner(),
      );

    if (model.postsState == null)
      return Center(
        child: Text("No Bookmarked Posts"),
      );

    final bookmarkedPosts = model.postsState.posts;
    final postKeys = bookmarkedPosts.keys.toList();
    return ListView.builder(
      itemCount: bookmarkedPosts.length,
      itemBuilder: (context, index) {
        return PostWidget(bookmarkedPosts[postKeys[index]], model);
      },
    );
  }
}
