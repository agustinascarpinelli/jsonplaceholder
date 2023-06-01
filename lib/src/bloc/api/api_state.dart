part of 'api_bloc.dart';


class ApiState {
final bool isConnected;

  ApiState({this.isConnected=true});

ApiState copyWith({
  bool? isConnect
})=> ApiState(isConnected:isConnect??isConnected);

}


