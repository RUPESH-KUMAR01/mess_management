part of 'approval_user_bloc.dart';

sealed class ApprovalUserState extends Equatable {
  const ApprovalUserState();
  
  @override
  List<Object> get props => [];
}

final class ApprovalUserInitial extends ApprovalUserState {}


final class ApprovalUserFailure extends ApprovalUserState{}

final class ApprovalUserLoading extends ApprovalUserState{}


final class ApprovalUserSuccess extends ApprovalUserState{}
