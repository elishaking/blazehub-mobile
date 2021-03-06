import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class AuthUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  // final int iat;
  // final int exp;

  AuthUser({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.username,
    // @required this.iat,
    // @required this.exp,
  });

  AuthUser copyWith({
    String id,
    String firstName,
    String lastName,
    String email,
    String username,
    int iat,
    int exp,
  }) =>
      AuthUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        username: username ?? this.username,
        // iat: iat ?? this.iat,
        // exp: exp ?? this.exp,
      );

  factory AuthUser.fromJSON(Map<dynamic, dynamic> json) {
    return AuthUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<dynamic, dynamic> toJSON() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
    };
  }
}

class AuthErrors {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  AuthErrors({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  });

  AuthErrors copyWith({
    String firstName,
    String lastName,
    String email,
    String password,
  }) =>
      AuthErrors(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      );
}

class AuthState {
  final bool isAuthenticated;
  final bool loading;
  final AuthUser user;
  final AuthErrors errors;
  final Uint8List smallProfilePicture;

  AuthState({
    @required this.isAuthenticated,
    @required this.loading,
    @required this.user,
    @required this.errors,
    @required this.smallProfilePicture,
  });

  AuthState copyWith({
    bool isAuthenticated,
    bool loading,
    AuthUser user,
    AuthErrors errors,
    Uint8List smallProfilePicture,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        loading: loading ?? this.loading,
        user: user ?? this.user,
        errors: errors ?? this.errors,
        smallProfilePicture: smallProfilePicture ?? this.smallProfilePicture,
      );
}

class UserSignupData {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String username = '';

  UserSignupData({this.firstName, this.lastName, this.email, this.password});

  toJSON() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
    };
  }
}

class UserSigninData {
  String email = '';
  String password = '';

  UserSigninData({this.email, this.password});
}
