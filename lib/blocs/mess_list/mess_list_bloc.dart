import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mess_list_event.dart';
part 'mess_list_state.dart';

class MessListBloc extends Bloc<MessListEvent, MessListState> {
  MessListBloc() : super(MessListInitial()) {
    on<MessListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
