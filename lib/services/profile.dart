import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';

class ProfileService {
  final _dbRef = FirebaseDatabase().reference();

  Future<Uint8List> getProfilePicture(String userID) async {
    try {
      final profilePictureSnapshot = await _dbRef
          .child('profile-photos')
          .child(userID)
          .child('avatar')
          .once();

      if (profilePictureSnapshot.value == null) return null;

      return Uri.parse(profilePictureSnapshot.value).data.contentAsBytes();
    } catch (err) {
      print(err);

      return null;
    }
  }
}
