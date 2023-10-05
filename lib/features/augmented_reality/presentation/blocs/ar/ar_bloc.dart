import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ArState extends Equatable {
  const ArState();

  @override
  List<Object> get props => [];
}

class ArInitial extends ArState {}

class ArSuccess extends ArState {
  final String? message;

  const ArSuccess({this.message});
}

class ArFailure extends ArState {
  final String? message;

  const ArFailure({this.message});
}

class ArLoading extends ArState {}

abstract class ArEvent extends Equatable {
  const ArEvent();

  @override
  List<Object> get props => [];
}

class ArLoadEvent extends ArEvent {}

class ArResetEvent extends ArEvent {}

class ArSettledEvent extends ArEvent {}

class ArSuccessEvent extends ArEvent {
  final String? message;

  const ArSuccessEvent({this.message});
}

class ArFailedEvent extends ArEvent {
  final String? message;

  const ArFailedEvent({this.message});
}

class ArBloc extends Bloc<ArEvent, ArState> {
  ArBloc() : super(ArInitial()) {
    on<ArResetEvent>((event, emit) {
      emit(ArInitial());
    });

    on<ArFailedEvent>((event, emit) {
      emit(ArFailure(message: event.message));
    });

    on<ArLoadEvent>((event, emit) {
      emit(ArLoading());
    });

    on<ArSettledEvent>((event, emit) {
      emit(const ArSuccess(message: "Model Loaded Successfully"));
    });
  }
}
