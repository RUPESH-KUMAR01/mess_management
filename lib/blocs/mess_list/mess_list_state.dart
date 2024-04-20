part of 'mess_list_bloc.dart';

sealed class MessListState extends Equatable {
  const MessListState();
  
  @override
  List<Object> get props => [];
}

final class MessListInitial extends MessListState {}

final class MessListLoading extends MessListState{}

final class MessListFailure extends MessListState{}

final class MessListSuccess extends MessListState{
  final List<Mess> messes;

  
  MessListSuccess(this.messes);

  @override
  List<Object> get props =>[messes];
}
