import 'dart:typed_data';

import 'package:blazehub/models/profile.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileService {
  final _dbRef = FirebaseDatabase.instance.reference();

  Future<Uint8List> getProfilePicture(String userID) async {

    print("called");
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

  Future<Uint8List> getCoverPicture(String userID) async {
    try {
      final coverPictureSnapshot = await _dbRef
          .child('profile-photos')
          .child(userID)
          .child('coverPhoto')
          .once();

      if (coverPictureSnapshot.value == null) return null;

      return Uri.parse(coverPictureSnapshot.value).data.contentAsBytes();
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<Profile> getProfileInfo(String userID) async {
    try {
      final profileInfoSnapshot =
          await _dbRef.child('profiles').child(userID).once();

      if (profileInfoSnapshot.value == null) return null;

      return Profile.fromJSON(profileInfoSnapshot.value);
    } catch (err) {
      print(err);

      return null;
    }
  }

  Future<bool> updateProfileInfo(String userID, Profile profileInfo) async {
    try {
      await _dbRef.child('profiles').child(userID).set(profileInfo.toJSON());

      return true;
    } catch (err) {
      print(err);

      return false;
    }
  }
}

final profileService = ProfileService();
