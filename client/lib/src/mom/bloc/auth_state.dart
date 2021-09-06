import 'package:client/src/mom/models/user.dart';

abstract class AuthenticationState {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User? user;
  AuthenticationAuthenticated({this.user});
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoggingOut extends AuthenticationState {}
