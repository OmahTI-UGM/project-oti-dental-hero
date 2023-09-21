// Event class representing user selections
import 'package:bloc/bloc.dart';

class DropdownEvent {
  final String selectedValue;
  DropdownEvent(this.selectedValue);
}

// State class representing the selected value
class DropdownState {
  final String selectedValue;
  DropdownState(this.selectedValue);
}

// BLoC for dropdown management
class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownState('Tidak ada')) {
    on<DropdownEvent>((event, emit) {
      emit(DropdownState(event.selectedValue));
    });
  }
}
