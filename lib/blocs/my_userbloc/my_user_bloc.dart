import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {

  final UserRepository _userRepository;
  final String _MyUserId;
  late final StreamSubscription _streamSubscription;

  MyUserBloc({
    required UserRepository myUserRepository,
    required MyUserId
  }) : _userRepository=myUserRepository,
  _MyUserId=MyUserId
  , super(const MyUserState.loading()) {
    _streamSubscription=myUserRepository.userdetails(_MyUserId).listen((event) {
      add(GetMyUser(MyUserId: _MyUserId));
     });
    on<GetMyUser>((event, emit) async {
      try {
        MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
        emit(MyUserState.success(myUser));
      } catch (e) {
        log(e.toString());
        emit(const MyUserState.failure());
      }
    });
  }

  @override
  Future<void> close(){
    _streamSubscription.cancel();
    return super.close();
  }
}
