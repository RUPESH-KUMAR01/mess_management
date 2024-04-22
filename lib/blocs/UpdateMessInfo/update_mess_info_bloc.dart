import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mess_repository/mess_repository.dart';

part 'update_mess_info_event.dart';
part 'update_mess_info_state.dart';

class UpdateMessInfoBloc extends Bloc<UpdateMessInfoEvent, UpdateMessInfoState> {
  MessRepository _messRepository;
  UpdateMessInfoBloc(
    MessRepository messRepository
  ) :_messRepository=messRepository, super(UpdateMessInfoInitial()) {
    on<SetMessInfo>((event, emit) async {
      emit(UpdateMessLoading());
      try {
        if(event.mess.Present<event.mess.Capacity){
          Mess mess=Mess.empty;
          mess= mess.copyWith(Capacity: event.mess.Capacity,
          MessNo: event.mess.MessNo,
          Present: event.mess.Present+event.add);
          await _messRepository.SetMess(mess);
          emit(UpdateMessSuccess(event.mess));
        }
      else{
        emit(UpdateMessTry());
      }
      } catch (e) {
        log(e.toString());
        emit(UpdateMessFailure());
      }
    });
  }
}
