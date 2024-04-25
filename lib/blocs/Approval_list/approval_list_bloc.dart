import 'dart:async';
import 'dart:developer';

import 'package:approval_repository/approval_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'approval_list_event.dart';
part 'approval_list_state.dart';

class ApprovalListBloc extends Bloc<ApprovalListEvent, ApprovalListState> {

  final ApprovalRepository=FirebaseApprovalRepository();
  late final StreamSubscription _streamSubscription;
  ApprovalListBloc() : super(ApprovalListInitial()) {
    _streamSubscription=ApprovalRepository.approvals.listen((event){
      add(GetApprovalList());
    });
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
