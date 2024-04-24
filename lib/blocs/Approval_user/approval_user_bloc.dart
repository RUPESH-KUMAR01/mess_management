import 'dart:async';
import 'dart:developer';

import 'package:approval_repository/approval_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'approval_user_event.dart';
part 'approval_user_state.dart';

class ApprovalUserBloc extends Bloc<ApprovalUserEvent, ApprovalUserState> {

  final ApprovalRepository=FirebaseApprovalRepository();


  ApprovalUserBloc(

  ) : super(ApprovalUserInitial()) {

    on<MessChangerequest>((event, emit) {
      emit(ApprovalUserLoading());
      try {
        ApprovalRepository.CreateApproval(event._approval);
        emit(ApprovalUserSuccess());
      } catch (e) {
        log(e.toString());
        emit(ApprovalUserFailure());
      }
    });
    on<RequestRemoval>((event, emit){
      emit(ApprovalUserLoading());
      try {
        ApprovalRepository.Remove(event.MyUserId);
        emit(ApprovalUserSuccess());
      } catch (e) {
        log(e.toString());
        emit(ApprovalUserFailure());
      }
    });
  }
}
