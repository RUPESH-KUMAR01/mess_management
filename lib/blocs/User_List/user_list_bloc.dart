import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserRepository _userRepository;
  late final StreamSubscription<List<MyUser>> _streamSubscription;
  UserListBloc(
    UserRepository userRepository
  ) : _userRepository=userRepository, super(UserListInitial()) {
    _streamSubscription=_userRepository.getallusers.listen((event) {
      add(GetUserList());
    },);
    on<GetUserList>((event, emit) async {
      List<MyUser> users;
      emit(UserListLoading());
      try {
        users=await _userRepository.GetAllUsers();
        emit(UserListSuccess(users));
      } catch (e) {
        log(e.toString());
        emit(UserListFailure());
      }
    });
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    // TODO: implement close
    return super.close();
  }
}
