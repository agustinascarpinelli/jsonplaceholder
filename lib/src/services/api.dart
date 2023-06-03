import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _url = 'jsonplaceholder.typicode.com';
  final String _users = '/users';
  final String _posts = '/posts';

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

  Future<dynamic> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'body': body}),
    );
    if (response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        final res = json.decode(response.body);
        return res;
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to create post');
    }
  }
}
