import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/post.dart';

class Bookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => PostViewModel(store),
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(),
        );
      },
    );
  }
}
