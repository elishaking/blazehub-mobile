import 'dart:typed_data';

import 'package:flutter/material.dart';

class SmallProfilePicture extends StatelessWidget {
  final Uint8List smallProfilePicture;
  final double padding;
  const SmallProfilePicture(this.smallProfilePicture, {this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        // width: 20,
        // height: 20,
        child: CircleAvatar(
          backgroundImage: MemoryImage(smallProfilePicture),
        ),
      ),
    );
  }
}
