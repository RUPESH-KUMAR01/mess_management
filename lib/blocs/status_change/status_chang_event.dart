part of 'status_chang_bloc.dart';

sealed class StatusChangEvent extends Equatable {
  const StatusChangEvent();

  @override
  List<Object> get props => [];
}

class MessStatusChange extends StatusChangEvent{
  
}