import 'package:flutter/foundation.dart';

class AuthUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final int iat;
  final int exp;

  AuthUser({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.username,
    @required this.iat,
    @required this.exp,
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
        iat: iat ?? this.iat,
        exp: exp ?? this.exp,
      );
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
  final AuthUser user;
  final AuthErrors errors;

  AuthState({
    @required this.isAuthenticated,
    @required this.user,
    @required this.errors,
  });

  AuthState copyWith({
    bool isAuthenticated,
    AuthUser user,
    AuthErrors errors,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        user: user ?? this.user,
        errors: errors ?? this.errors,
      );
}
