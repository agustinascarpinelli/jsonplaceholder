part of 'services_bloc.dart';

 class ServicesState {

 final bool isLoading;
 final List <UsersResponse>? users;
 final  List<PostResponse>? posts;
 final String? error;
  final String? errorPost;
final bool isCreated;
  ServicesState({this.errorPost, this.isCreated=false, this.error, this.isLoading=false, this.users, this.posts});

ServicesState copyWith({
  final bool ? isLoading,
  final List <UsersResponse>? users,
  final  List<PostResponse>? posts,
  final String ? error,
    final String ? errorPost,
  final bool ? isCreated,
  

})=>ServicesState(errorPost:errorPost??this.errorPost,error: error?? this.error,isLoading: isLoading??this.isLoading,users:users??this.users,posts:posts??this.posts,isCreated: isCreated?? this.isCreated);

 }

