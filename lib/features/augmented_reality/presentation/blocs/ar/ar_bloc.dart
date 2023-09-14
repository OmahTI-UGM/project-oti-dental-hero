import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ArState extends Equatable {
  const ArState();

  @override
  List<Object> get props => [];
}

class ArInitial extends ArState {}

class ArSuccess extends ArState {}

class ArFailure extends ArState {}

class ArLoading extends ArState {}

abstract class ArEvent extends Equatable {
  const ArEvent();

  @override
  List<Object> get props => [];
}

class ArStarted extends ArEvent {}

class ArStopped extends ArEvent {}

class ArReset extends ArEvent {}

class ArBloc extends Bloc<ArEvent, ArState> {
  ArBloc() : super(ArInitial()) {
    on<ArReset>((event, emit) {
      emit(ArInitial());
    });
  }
}
