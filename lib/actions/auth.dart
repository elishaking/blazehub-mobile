import 'package:blazehub/models/auth.dart';
import 'package:blazehub/services/auth.dart';

class GetErrors {
  final payload;

  GetErrors(this.payload);
}

class SetCurrentUser {
  final AuthUser payload;

  SetCurrentUser(this.payload);
}

signupUser(email, password) => (Function dispatch) async {
      final firebaseUser = await authService.signupWithEmail(email, password);
      final user = AuthUser(
        email: firebaseUser.email,
        username: firebaseUser.displayName,
      );

      dispatch(SetCurrentUser(user));
    };
