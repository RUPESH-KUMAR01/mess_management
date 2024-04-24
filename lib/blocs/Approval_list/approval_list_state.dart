part of 'approval_list_bloc.dart';

abstract class ApprovalListState extends Equatable {
  const ApprovalListState();
  
  @override
  List<Object> get props => [];
}

final class ApprovalListInitial extends ApprovalListState {}


final class ApprovalListFailure extends ApprovalListState{}
final class ApprovalListLoading extends ApprovalListState{}
final class ApprovalListSuccess extends ApprovalListState{
  List<Approval> ApprovalList;

  ApprovalListSuccess(this.ApprovalList); 
}