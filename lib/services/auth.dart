import 'package:blazehub/models/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class _AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase();

  Future<AuthUser> signupWithEmail(UserSignupData userData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );

      final userKey = userData.email.replaceAll(".", "~").replaceAll("@", "~~");

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
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _updateDatabaseWithUser(
    UserSignupData userData,
    String userKey,
  ) {
    final dbRef = _database.reference();

    return dbRef.child('users').child(userKey).set(userData.toJSON()).then((_) {
      // create default blazebot friend
      const data = {
        "blazebot": {
          "name": "BlazeBot",
        }
      };
      return dbRef.child('friends').child(userKey).set(data);
    }).then((_) {
      return dbRef
          .child('profiles')
          .child(userKey)
          .child('username')
          .set(userData.username);
    });
  }
}

final authService = new _AuthService();
