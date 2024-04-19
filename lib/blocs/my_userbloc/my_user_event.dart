part of 'my_user_bloc.dart';

abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}


class GetMyUser extends MyUserEvent{
  final String MyUserId;

  const GetMyUser({required this.MyUserId});

  @override
  List<Object> get props => [MyUserId];
}