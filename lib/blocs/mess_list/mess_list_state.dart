part of 'mess_list_bloc.dart';

sealed class MessListState extends Equatable {
  const MessListState();
  
  @override
  List<Object> get props => [];
}

final class MessListInitial extends MessListState {}
