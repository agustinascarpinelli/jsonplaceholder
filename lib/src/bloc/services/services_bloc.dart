import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/models.dart';
import 'package:jsonplaceholder/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesState(isLoading: false)) {
    on<GetPosts>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      if (event.isConnected) {
        try {
          final posts = await getPosts();
          emit(state.copyWith(posts: posts, isLoading: false));
          String previousPostData = jsonEncode(posts);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('previousPostData', previousPostData);
        } catch (e) {
          final error = e.toString();
          emit(state.copyWith(error: error, isLoading: false));
        }
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? previousPostData = prefs.getString('previousPostData');
        if (previousPostData != null) {
          final postsResponse = postResponseFromJson(previousPostData);
          emit(state.copyWith(isLoading: false, posts: postsResponse));
        } else {
          emit(state.copyWith(
              isLoading: false, error: 'Need conexion to read posts'));
        }
      }
    });

    on<GetUsers>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      if (event.isConnected) {
        try {
          final users = await getUsers();
          emit(state.copyWith(users: users, isLoading: false));
          String previousUserData = jsonEncode(users);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('previousUserData', previousUserData);
        } catch (e) {
          final error = e.toString();
          emit(state.copyWith(error: error, isLoading: false));
        }
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? previousUserData = prefs.getString('previousUserData');
        if (previousUserData != null) {
          final usersResponse = usersResponseFromJson(previousUserData);
          emit(state.copyWith(users: usersResponse, isLoading: false));
        } else {
          emit(state.copyWith(
              isLoading: false, error: 'Need conexion to read users'));
        }
      }
    });

    on<CreatePost>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final response = await ApiService().createPost(event.title, event.body);
      
        final post = PostResponse.fromJson(response);
        emit(state.copyWith(isCreated:true,isLoading: false,posts: [post, ...state.posts!]));
      } catch (e) {
        final error=e.toString();
        print(error);
        emit(state.copyWith(isCreated:false,isLoading: false,errorPost:error ));
      }
    });

    on<OnPostCreated>((event,emit)=>emit(state.copyWith(isCreated: false))
    );
  }

  Future<List<PostResponse>> getPosts() async {
    final data = await ApiService().getPostRaw();
    final postsResponse = postResponseFromJson(data);
    return postsResponse;
  }

  Future<List<UsersResponse>> getUsers() async {
    final data = await ApiService().getUsersRaw();
    final usersResponse = usersResponseFromJson(data);
    return usersResponse;
  }
}
