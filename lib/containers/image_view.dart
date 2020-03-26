import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final UriData imageUri;

  const ImageView(this.imageUri);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.memory(
          imageUri.contentAsBytes(),
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
