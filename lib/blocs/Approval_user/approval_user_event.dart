part of 'approval_user_bloc.dart';

sealed class ApprovalUserEvent extends Equatable {
  const ApprovalUserEvent();

  @override
  List<Object> get props => [];
}


class MessChangerequest extends ApprovalUserEvent{
  final Approval _approval;
  MessChangerequest(this._approval);
}


class RequestRemoval extends ApprovalUserEvent{
  final String MyUserId;

  RequestRemoval(this.MyUserId);
}

class SetRequest extends ApprovalUserEvent{
  Approval approval;
  SetRequest(this.approval);
}