part of 'mess_create_bloc.dart';

sealed class MessCreateEvent extends Equatable {
  const MessCreateEvent();

  @override
  List<Object> get props => [];
}

class CreateMess extends MessCreateEvent{
  final Mess mess;
  const CreateMess(this.mess);
}
