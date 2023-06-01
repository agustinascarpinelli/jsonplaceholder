
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AuthProvider{

Future<String> getJson() {
  return rootBundle.loadString('users.json');
}
login (String email, String password)async{
     Map<String, dynamic> user  = json.decode(await getJson());
   
   print (user);

}
}

