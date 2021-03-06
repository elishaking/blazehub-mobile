import 'dart:typed_data';

import 'package:blazehub/containers/small_profile_picture_view.dart';
import 'package:blazehub/values/colors.dart';
import 'package:flutter/material.dart';

class SmallProfilePicture extends StatelessWidget {
  static const String AUTH_USER = 'auth-user';

  final Uint8List smallProfilePicture;
  final double padding;
  final String uniqueID;
  final String pictureID;

  const SmallProfilePicture(
    this.smallProfilePicture, {
    @required this.uniqueID,
    @required this.pictureID,
    this.padding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        // width: 20,
        // height: 20,
        child: smallProfilePicture == null
            ? Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white54,
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SmallProfilePictureView(
                      smallProfilePicture,
                      uniqueID,
                      pictureID,
                    ),
                    fullscreenDialog: true,
                  ));
                },
                child: Hero(
                  tag: uniqueID,
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(smallProfilePicture),
                  ),
                ),
              ),
      ),
    );
  }
}
