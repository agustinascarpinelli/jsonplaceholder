import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(isAuth: false)) {
    on<Login>((event, emit) async {
      final bool isAuth = await log(event.user, event.password);
      if (isAuth) {
        emit(state.copyWith(email: event.user, isAuth: true));
      } else {
        emit(state.copyWith(isAuth: false));
      }
    });

    on<Logout>((event, emit) {
      emit(state.copyWith(isAuth: false));
    });
  }

  signin(String email, String password) {
    if (email == 'challenge@fudo' && password == 'password') {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getJson() {
    return rootBundle.loadString('db/users.json');
  }

  Future<bool> log(String email, String password) async {
    String jsonData = await getJson();
    Map<String, dynamic> data = json.decode(jsonData);
    List<dynamic> users = data['users'];

    for (var user in users) {
      String userEmail = user['info']['email'];
      String userPassword = user['info']['password'];

      if (userEmail == email && userPassword == password) {
        return true;
      }
    }

    return false;
  }
}
