part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent{
  final String user;
  final String password;

  Login(this.user, this.password);

}

class Logout extends AuthEvent{
  
}