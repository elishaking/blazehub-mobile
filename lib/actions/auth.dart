// todo: implement auth actions
import 'package:blazehub/models/auth.dart';

class GetErrors {
  final payload;

  GetErrors(this.payload);
}

class SetCurrentUser {
  final AuthUser payload;

  SetCurrentUser(this.payload);
}
