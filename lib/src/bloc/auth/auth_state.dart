part of 'auth_bloc.dart';

 class AuthState {
final String? user;
final bool isAuth;

  AuthState({this.user, this.isAuth=false});

  AuthState copyWith({
    String? email,
    bool? isAuth
  })=>AuthState(user:email??user,isAuth:isAuth?? this.isAuth);

 }


