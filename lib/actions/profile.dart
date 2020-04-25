import 'dart:typed_data';

import 'package:blazehub/models/profile.dart';

class SetProfilePicture {
  final Uint8List payload;
  final bool isAuthUser;

  SetProfilePicture(this.payload, this.isAuthUser);
}

class SetCoverPicture {
  final Uint8List payload;
  final bool isAuthUser;

  SetCoverPicture(this.payload, this.isAuthUser);
}

class SetProfileInfo {
  final Profile payload;
  final bool isAuthUser;

  SetProfileInfo(this.payload, this.isAuthUser);
}
