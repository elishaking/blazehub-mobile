import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final Uint8List imageBytes;
  final String postID;

  const ImageView(this.imageBytes, this.postID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: postID,
          child: Image.memory(
            imageBytes,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
