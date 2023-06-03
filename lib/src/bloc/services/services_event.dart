part of 'services_bloc.dart';

@immutable
abstract class ServicesEvent {}

class GetPosts extends ServicesEvent{
  final bool isConnected;

  GetPosts(this.isConnected);


}

class GetUsers extends ServicesEvent {
  final bool isConnected;

  GetUsers(this.isConnected);

}

class CreatePost extends ServicesEvent {

  final String title;
  final String body;


  CreatePost(this.title, this.body);}


  class OnPostCreated extends ServicesEvent{}