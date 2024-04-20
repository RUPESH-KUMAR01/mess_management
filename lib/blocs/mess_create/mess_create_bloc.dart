import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mess_repository/mess_repository.dart';
part 'mess_create_event.dart';
part 'mess_create_state.dart';

class MessCreateBloc extends Bloc<MessCreateEvent, MessCreateState> {
  MessRepository _messRepository;
  MessCreateBloc({
    required MessRepository messRepository
  }) :_messRepository=messRepository ,
  super(MessCreateInitial()) {
    on<CreateMess>((event, emit) async {
      emit(CreateMessLoading());
      try {
        Mess mess=await _messRepository.CreateMess(event.mess);
        if(mess.MessNo==-1){
          emit(CreateMessFailure());
        }else{
          emit(CreateMessSuccess(mess));
        }

      } catch (e) {
        emit(CreateMessFailure());
        log(e.toString());
      }
    });
  }
}
