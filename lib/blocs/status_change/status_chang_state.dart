part of 'status_chang_bloc.dart';

abstract class StatusChangState extends Equatable {
  const StatusChangState();
  
  @override
  List<Object?> get props => [];
}

final class StatusChangInitial extends StatusChangState {}




final class ApprovalStatusFailure extends StatusChangState{}

final class ApprovalStatusLoading extends StatusChangState{}


class ApprovalStatusSuccess extends StatusChangState{
  Approval approval;

  ApprovalStatusSuccess(this.approval);
  @override
  List<Object?> get props =>[approval];
}