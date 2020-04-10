import 'dart:typed_data';

import 'package:blazehub/components/SmallProfilePicture.dart';
import 'package:blazehub/components/Spinner.dart';
import 'package:blazehub/models/app.dart';
import 'package:blazehub/view_models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SmallProfilePictureView extends StatefulWidget {
  final Uint8List smallProfilePicture;
  final String heroTag;

  SmallProfilePictureView(this.smallProfilePicture, this.heroTag);

  @override
  _SmallProfilePictureViewState createState() =>
      _SmallProfilePictureViewState();
}

class _SmallProfilePictureViewState extends State<SmallProfilePictureView> {
  Uint8List fullImage;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: (store) => ProfileViewModel.create(store),
      builder: (context, model) {
        if (widget.heroTag == SmallProfilePicture.AUTH_USER) {
          if (model.profileState.profilePicture == null)
            model.getProfilePicture(model.authState.user.id);
          else
            fullImage = model.profileState.profilePicture;
        } else {}

        return Scaffold(
          appBar: AppBar(),
          body: Center(
              child: fullImage == null
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Hero(
                          tag: widget.heroTag,
                          child: Image.memory(
                            widget.smallProfilePicture,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Spinner(),
                      ],
                    )
                  : Hero(
                      tag: widget.heroTag,
                      child: Image.memory(
                        fullImage,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    )),
        );
      },
    );
  }
}
