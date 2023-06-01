import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier {
  final String _url = 'jsonplaceholder.typicode.com';
  final String _users = '/users';
  final String _posts = '/posts';
  bool isLoading = false;
  bool isCreated = false;
  bool isConnecting = false;

  List<UsersResponse> users = [];
  List<PostResponse> posts = [];

  ApiProvider() {
    isConnect().then((value) {
      if (isConnected) {
        print('iconnec');
        getUsers();
        getPosts();
      } else {
        print('isnotconnec');
        // Cargar datos previos en caso de no haber conexión
        loadPreviousData();
      }
    });
  }

  bool get isConnected=>isConnecting;

  Future <void> isConnect() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnecting = false;
    } else {
      isConnecting = true;
    }
   notifyListeners();
    
  }

  Future<String> getUsersRaw() async {
    final url = Uri.https(_url, _users);
    final response = await http.get(url);

    return response.body;
  }

  Future<String> getPostRaw() async {
    final url = Uri.https(_url, _posts);
    final response = await http.get(url);

    return response.body;
  }

  void getUsers() async {
    isLoading = true;
    final data = await getUsersRaw();
    final usersResponse = usersResponseFromJson(data);
    users.addAll(usersResponse);
    isLoading = false;
    await savePreviousData();
    notifyListeners();
  }

  void getPosts() async {
    isLoading = true;
    final data = await getPostRaw();
    final postsResponse = postResponseFromJson(data);
    posts.addAll(postsResponse);
    isLoading = false;
    await savePreviousData();

    notifyListeners();
  }


  Future savePreviousData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

 
  String previousUserData = jsonEncode(users);
  String previousPostData = jsonEncode(posts);

  prefs.setString('previousUserData', previousUserData);
  prefs.setString('previousPostData', previousPostData);
}

  void loadPreviousData()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();


  String? previousUserData = prefs.getString('previousUserData');
  String? previousPostData = prefs.getString('previousPostData');

  if (previousUserData != null) {
    final usersResponse = usersResponseFromJson(previousUserData);
    users.addAll(usersResponse);
  }

  if (previousPostData != null) {
    final postsResponse = postResponseFromJson(previousPostData);
    posts.addAll(postsResponse);
  }

  notifyListeners();
}


  Future createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'body': body}),
    );
    if (response.statusCode == 201) {
      isCreated = true;
      final res = json.decode(response.body);
      final post = PostResponse.fromJson(res);

      posts = [post, ...posts];
    } else {
      isCreated = false;
    }
    notifyListeners();
  }
}
