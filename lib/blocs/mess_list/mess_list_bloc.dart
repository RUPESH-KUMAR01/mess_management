import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mess_repository/mess_repository.dart';

part 'mess_list_event.dart';
part 'mess_list_state.dart';

class MessListBloc extends Bloc<MessListEvent, MessListState> {
  MessRepository _messRepository;
  late final StreamSubscription<List<Mess>?> _streamSubscription;
  MessListBloc({required MessRepository messRepository}) 
  :_messRepository=messRepository, 
  super(MessListInitial()) {
    _streamSubscription=messRepository.messes.listen((val){
      add(GetMessList());
    });
    on<GetMessList>((event, emit) async {
      emit(MessListLoading());
      try {
        List<Mess> messes=await _messRepository.GetMess();
        emit(MessListSuccess(messes));
      } catch (e) {
        emit(MessListFailure());
      }
    });
  @override
  Future<void> close(){
    _streamSubscription.cancel();
    return super.close();
  }
  }
}
