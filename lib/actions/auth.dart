import 'dart:typed_data';

import 'package:blazehub/models/auth.dart';

class GetErrors {
  final payload;

  GetErrors(this.payload);
}

class UpdateLoading {
  final bool payload;

  UpdateLoading(this.payload);
}

class SetCurrentUser {
  final AuthUser payload;

  SetCurrentUser(this.payload);
}

class SetSmallProfilePicture {
  final Uint8List payload;

  SetSmallProfilePicture(this.payload);
}
