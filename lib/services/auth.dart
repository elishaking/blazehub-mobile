import 'dart:typed_data';

import 'package:blazehub/models/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class _AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();

  Future<AuthUser> signupWithEmail(UserSignupData userData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );

      final userKey = _getUserKey(userData.email);

      userData.username =
          '${userData.firstName.replaceAll(" ", "")}.${userData.lastName.replaceAll(" ", "")}'
              .toLowerCase();

      await _updateDatabaseWithUser(userData, userKey);

      return AuthUser(
        id: userKey,
        firstName: userData.firstName,
        lastName: userData.lastName,
        email: userData.email,
        username: userData.username,
      );
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future<AuthUser> signinWithEmail(UserSigninData userData) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );

      final userKey = _getUserKey(userData.email);
      final user = await _getUserFromDatabase(userKey);

      return user;
    } catch (err) {
      print(err.toString());

      return null;
    }
  }

  Future<void> _updateDatabaseWithUser(
    UserSignupData userData,
    String userKey,
  ) {
    return _dbRef
        .child('users')
        .child(userKey)
        .set(userData.toJSON())
        .then((_) {
      // create default blazebot friend
      const data = {
        "blazebot": {
          "name": "BlazeBot",
        }
      };
      return _dbRef.child('friends').child(userKey).set(data);
    }).then((_) {
      return _dbRef
          .child('profiles')
          .child(userKey)
          .child('username')
          .set(userData.username);
    });
  }

  Future<AuthUser> _getUserFromDatabase(String userKey) {
    return _dbRef.child('users').child(userKey).once().then((userSnapshot) {
      final userData = userSnapshot.value;
      userData['id'] = userSnapshot.key;

      return AuthUser.fromJSON(userData);
    });
  }

  Future<Uint8List> getSmallProfilePicture(userID) async {
    try {
      final smallProfilePictureSnapshot = await _dbRef
          .child('profile-photos')
          .child(userID)
          .child('avatar-small')
          .once();

      if (smallProfilePictureSnapshot.value == null) return null;

      return Uri.parse(smallProfilePictureSnapshot.value).data.contentAsBytes();
    } catch (err) {
      print(err);

      return null;
    }
  }

  String _getUserKey(String email) =>
      email.replaceAll(".", "~").replaceAll("@", "~~");
}

final authService = new _AuthService();
