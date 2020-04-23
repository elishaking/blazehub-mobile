import 'dart:typed_data';

import 'package:blazehub/models/profile.dart';

class SetProfilePicture {
  final Uint8List payload;
  final bool isAuthUser;

  SetProfilePicture(this.payload, this.isAuthUser);
}

class SetCoverPicture {
  final Uint8List payload;

  SetCoverPicture(this.payload);
}

class SetProfileInfo {
  final Profile payload;

  SetProfileInfo(this.payload);
}
