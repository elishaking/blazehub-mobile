import 'dart:typed_data';

import 'package:blazehub/components/Spinner.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SmallProfilePictureView extends StatelessWidget {
  final Uint8List smallProfilePicture;
  final String heroTag;

  SmallProfilePictureView(this.smallProfilePicture, this.heroTag);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FriendViewModel>(
      converter: (store) => FriendViewModel(store),
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Hero(
                  tag: heroTag,
                  child: Image.memory(
                    smallProfilePicture,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                Spinner(),
              ],
            ),
          ),
        );
      },
    );
  }
}
