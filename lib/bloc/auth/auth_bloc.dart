import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>(_onAuthEvent);
  }

  _onAuthEvent(AuthEvent event, Emitter emit) {
    emit(AuthState(isAuthorized: event.isAuthorized));
  }
}

class AuthEvent {
  final bool isAuthorized;

  AuthEvent(this.isAuthorized);
}

class AuthState {
  final bool isAuthorized;

  AuthState({this.isAuthorized = false});
}
