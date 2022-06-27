import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc() : super(InboxState()) {
    debugPrint('initializing InboxBloc');
    on<InboxEvent>(_onTestEvent);
  }

  void _onTestEvent(InboxEvent event, Emitter<InboxState> emit) {}

  @override
  Future<void> close() {
    debugPrint('closing InboxBloc');
    return super.close();
  }
}

class InboxEvent {}

class InboxState {}
