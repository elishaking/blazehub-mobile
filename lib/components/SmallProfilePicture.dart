import 'dart:typed_data';

import 'package:flutter/material.dart';

class SmallProfilePicture extends StatelessWidget {
  final Uint8List smallProfilePicture;
  const SmallProfilePicture(this.smallProfilePicture);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
