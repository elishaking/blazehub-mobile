import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class Profile {
  String name;
  String username;
  String website;
  String birth;
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

  factory Profile.fromJSON(Map json) {
    return Profile(
      name: json['name'],
      username: json['username'],
      website: json['website'],
      birth: json['birth'],
      bio: json['bio'],
      location: json['location'],
    );
  }

  Map toJSON() {
    return {
      'name': name,
      'username': username,
      'website': website,
      'birth': birth,
      'bio': bio,
      'location': location,
    };
  }

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
  Uint8List profilePictureNotAuth;
  Uint8List coverPicture;
  Uint8List coverPictureNotAuth;
  Profile profileInfo;
  Profile profileInfoNothAuth;

  ProfileState({
    @required this.profilePicture,
    @required this.profilePictureNotAuth,
    @required this.coverPicture,
    @required this.coverPictureNotAuth,
    @required this.profileInfo,
    @required this.profileInfoNothAuth,
  });

  ProfileState copyWith({
    Uint8List profilePicture,
    Uint8List profilePictureNotAuth,
    Uint8List coverPicture,
    Profile profileInfo,
  }) {
    return ProfileState(
      profilePicture: profilePicture ?? this.profilePicture,
      profilePictureNotAuth:
          profilePictureNotAuth ?? this.profilePictureNotAuth,
      coverPicture: coverPicture ?? this.coverPicture,
      coverPictureNotAuth: coverPictureNotAuth ?? this.coverPictureNotAuth,
      profileInfo: profileInfo ?? this.profileInfo,
      profileInfoNothAuth: profileInfoNothAuth ?? this.profileInfoNothAuth,
    );
  }
}
