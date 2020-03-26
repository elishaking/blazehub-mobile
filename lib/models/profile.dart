import 'dart:typed_data';
import 'package:blazehub/pages/profile.dart';
import 'package:flutter/foundation.dart';

class Profile {
  String name;
  String username;
  String website;
  int birth;
  String bio;
  String location;

  Profile({
    @required this.name,
    @required this.username,
    @required this.website,
    @required this.birth,
    @required this.bio,
    @required this.location,
  });

  Profile copyWith({
    String name,
    String username,
    String website,
    int birth,
    String bio,
    String location,
  }) =>
      Profile(
        name: name ?? this.name,
        username: username ?? this.username,
        website: website ?? this.website,
        birth: birth ?? this.birth,
        bio: bio ?? this.bio,
        location: location ?? this.location,
      );
}

class ProfileState {
  Uint8List profilePicture;
  Uint8List coverPicture;
  Profile profileInfo;

  ProfileState({
    @required this.profilePicture,
    @required this.coverPicture,
    @required this.profileInfo,
  });

  ProfileState copyWith({
    Uint8List profilePicture,
    Uint8List coverPicture,
    Profile profileInfo,
  }) {
    return ProfileState(
      profilePicture: profilePicture ?? this.profilePicture,
      coverPicture: coverPicture ?? this.coverPicture,
      profileInfo: profileInfo ?? this.profileInfo,
    );
  }
}
