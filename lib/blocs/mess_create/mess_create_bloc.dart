import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mess_create_event.dart';
part 'mess_create_state.dart';

class MessCreateBloc extends Bloc<MessCreateEvent, MessCreateState> {
  MessCreateBloc() : super(MessCreateInitial()) {
    on<MessCreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
