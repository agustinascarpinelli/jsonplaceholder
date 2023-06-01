

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'api_event.dart';
part 'api_state.dart';
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiState(isConnected: true)) {
    on<ApiEvent>((event, emit) async {
      if (event is OnIsConnected) {
        await _handleOnIsConnected(event, emit);
      }
    });
  }

  Future<void> _handleOnIsConnected(OnIsConnected event, Emitter<ApiState> emit) async {
    final isConnected = await isConnect();
    if (!emit.isDone) {
      emit(state.copyWith(isConnect: isConnected));
    }
  }

  Future<bool> isConnect() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}