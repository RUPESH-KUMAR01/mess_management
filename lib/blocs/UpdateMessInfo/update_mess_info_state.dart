part of 'update_mess_info_bloc.dart';

sealed class UpdateMessInfoState extends Equatable {
  const UpdateMessInfoState();
  
  @override
  List<Object> get props => [];
}

final class UpdateMessInfoInitial extends UpdateMessInfoState {}
