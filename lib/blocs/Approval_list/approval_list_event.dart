part of 'approval_list_bloc.dart';

sealed class ApprovalListEvent extends Equatable {
  const ApprovalListEvent();

  @override
  List<Object> get props => [];
}


class GetApprovalList extends ApprovalListEvent{

}
