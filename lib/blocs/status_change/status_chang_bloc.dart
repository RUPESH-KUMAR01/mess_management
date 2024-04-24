import 'dart:async';
import 'dart:developer';

import 'package:approval_repository/approval_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_chang_event.dart';
part 'status_chang_state.dart';

class StatusChangBloc extends Bloc<StatusChangEvent, StatusChangState> {
  final ApprovalRepository=FirebaseApprovalRepository();
  String _MyUserId;
  late StreamSubscription _streamSubscription;
  
  StatusChangBloc(
        {required String MyUserId}
  ) : _MyUserId=MyUserId,super(StatusChangInitial()) {
  _streamSubscription=ApprovalRepository.ApprovalStatus(_MyUserId).listen((event) {
      add(MessStatusChange());
    },);
   on<MessStatusChange>((event, emit) async {
      emit(ApprovalStatusLoading());
      try {
        Approval _approval=await ApprovalRepository.Status(_MyUserId);
        emit(ApprovalStatusSuccess(_approval)); 
      } catch (e) {
        log(e.toString());
        emit(ApprovalStatusFailure());
      }
    } );
  }
  @override
  Future<void> close(){
    _streamSubscription.cancel();
    return super.close();
  }
}
