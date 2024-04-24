import 'dart:developer';

import 'package:approval_repository/approval_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'approval_list_event.dart';
part 'approval_list_state.dart';

class ApprovalListBloc extends Bloc<ApprovalListEvent, ApprovalListState> {

  final ApprovalRepository=FirebaseApprovalRepository();

  ApprovalListBloc() : super(ApprovalListInitial()) {
    on<GetApprovalList>((event, emit) async {
      emit(ApprovalListLoading());
      try {
        List<Approval> ApprovalList;
        ApprovalList=await ApprovalRepository.GetApprovals();
        emit(ApprovalListSuccess(ApprovalList));
      } catch (e) {
        log(e.toString());
        emit(ApprovalListFailure());
      }
    });
  }
}
