part of 'user_list_bloc.dart';

sealed class UserListState extends Equatable {
  const UserListState();
  
  @override
  List<Object> get props => [];
}

final class UserListInitial extends UserListState {}


final class UserListLoading extends UserListState{}

final class UserListFailure extends UserListState{}

final class UserListSuccess extends UserListState{
  final List<MyUser> users;

  UserListSuccess(this.users);
}