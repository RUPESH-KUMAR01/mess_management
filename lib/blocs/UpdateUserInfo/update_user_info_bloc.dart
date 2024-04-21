import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_repository/mess_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
 UserRepository _userRepository;
  UpdateUserInfoBloc(UserRepository userRepository) :
  _userRepository=userRepository
  , super(UpdateUserInfoInitial()) {
    on<SetUserInfo>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
        MyUser new_user=myUser.copyWith(
          Alloted: true,
          MessNo: event.mess.MessNo
        );
        _userRepository.setUserData(new_user);
      } catch (e) {
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
    });
  }
}
