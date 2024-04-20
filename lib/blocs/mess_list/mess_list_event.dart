part of 'mess_list_bloc.dart';

abstract class MessListEvent extends Equatable {
  const MessListEvent();

  @override
  List<Object> get props => [];
}

class GetMessList extends MessListEvent{
  
}

