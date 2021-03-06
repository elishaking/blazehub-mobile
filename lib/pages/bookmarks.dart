import 'package:blazehub/components/post_widget.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/post.dart';

class Bookmarks extends StatefulWidget {
  // static bool retrievedBookmarks = false;

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  PostViewModel mModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostViewModel>(
      converter: (Store<AppState> store) => PostViewModel(store),
      builder: (context, model) {
        mModel = model;

        final retrievedBookmarks = model.postsState.posts != null;
        if (!retrievedBookmarks) model.getBookmarks(model.authState.user.id);

        return Scaffold(
          appBar: AppBar(
            title: Text('Bookmarks'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: _buildBookmarks(model, retrievedBookmarks),
          ),
        );
      },
    );
  }

  Widget _buildBookmarks(
      final PostViewModel model, final bool retrievedBookmarks) {
    if (!retrievedBookmarks)
      return Center(
        child: Spinner(),
      );

    if (model.postsState.posts == null)
      return Center(
        child: Text("No Bookmarked Posts"),
      );

    final bookmarkedPosts = model.postsState.posts
      ..removeWhere((_, post) => post.isBookmarked == false);
    final postKeys = bookmarkedPosts.keys.toList();
    return ListView.builder(
      itemCount: bookmarkedPosts.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (dir) {
            model.togglePostBookmark(
                postKeys[index], model.authState.user.id, true);
          },
          child: PostWidget(
            bookmarkedPosts[postKeys[index]],
            model,
            shouldDisplayBookmarkButton: false,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (mModel != null) mModel.resetPosts();

    super.dispose();
  }
}
