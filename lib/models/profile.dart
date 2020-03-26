import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class ProfileState {
  Uint8List profilePicture;
  Uint8List coverPicture;

  ProfileState({
    @required this.profilePicture,
    @required this.coverPicture,
  });

  ProfileState copyWith({
    Uint8List profilePicture,
  }) {
    return ProfileState(
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
    );
  }
}
