part of 'mess_create_bloc.dart';

sealed class MessCreateState extends Equatable {
  const MessCreateState();
  
  @override
  List<Object> get props => [];
}

final class MessCreateInitial extends MessCreateState {}


final class CreateMessFailure extends MessCreateState{}
final class CreateMessLoading extends MessCreateState{}

final class CreateMessSuccess extends MessCreateState{
  final Mess mess;
  const CreateMessSuccess(this.mess);
}
