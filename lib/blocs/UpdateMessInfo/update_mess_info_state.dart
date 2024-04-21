part of 'update_mess_info_bloc.dart';

sealed class UpdateMessInfoState extends Equatable {
  const UpdateMessInfoState();
  
  @override
  List<Object> get props => [];
}

final class UpdateMessInfoInitial extends UpdateMessInfoState {}

final class UpdateMessLoading extends UpdateMessInfoState{}

final class UpdateMessFailure extends UpdateMessInfoState{}


final class UpdateMessTry extends UpdateMessInfoState{}

final class UpdateMessSuccess extends UpdateMessInfoState{
  final Mess mess;

  const UpdateMessSuccess(this.mess);
}
