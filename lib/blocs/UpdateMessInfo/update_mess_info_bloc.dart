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
          mess= event.mess.copyWith(Capacity: event.mess.Capacity,
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

    on<SetMessInfobyMessNo>((event,emit) async {
      emit(UpdateMessLoading());
      try {
        Mess mess=await _messRepository.MessInfo(event.MessNo);
        Mess new_mess=mess.copyWith(Present: mess.Present-1);
        await _messRepository.SetMess(new_mess);
        print(mess.Present-1);
        print(new_mess.Present);
        emit(UpdateMessSuccess(new_mess));
      } catch (e) {
        log(e.toString());
        emit(UpdateMessFailure());
      }
    });

    on<SetChangeInfo>((event, emit) async {
      emit(UpdateMessLoading());
      try{
      Mess iMess=await _messRepository.MessInfo(event.iMessNo);
      Mess fMess=await _messRepository.MessInfo(event.fMessNo);
      Mess _iMess=iMess.copyWith(Present: iMess.Present-1);
      Mess _fMess=fMess.copyWith(Present: fMess.Present+1);
      _messRepository.SetMess(_iMess);
      _messRepository.SetMess(_fMess);
      emit(UpdateMessSuccess(Mess.empty));
      }catch(e){
        log(e.toString());
        emit(UpdateMessFailure());
      }

    });
  }
}
