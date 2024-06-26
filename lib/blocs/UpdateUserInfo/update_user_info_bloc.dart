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
          change:false,
          MessNo: event.mess.MessNo
        );
        _userRepository.setUserData(new_user);
        emit(UpdateUserInfoSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
    });

    on<SetUserInfobyMessNo>((event, emit) async{
      emit(UpdateUserInfoLoading());
      try{
      MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
      MyUser new_user=myUser.copyWith(
        Alloted: false);
      _userRepository.setUserData(new_user);
      emit(UpdateUserInfoSuccess());}
      catch(e){
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
      
    } );
    on<SetUserBalance>(
      (event,emit) async {
              emit(UpdateUserInfoLoading());
      try {
        MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
        MyUser new_user=myUser.copyWith(
          Balance: ((myUser.Balance) + event.AddBalance) as int
        );
        _userRepository.setUserData(new_user);
        emit(UpdateUserInfoSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
      }
    );
    on<SetChangeRequest> ((event, emit) async{
                    emit(UpdateUserInfoLoading());
      try {
        MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
        MyUser new_user=myUser.copyWith(
          change: event._change
        );
        _userRepository.setUserData(new_user);
        emit(UpdateUserInfoSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
    });
    on<UserMessUpdate>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        MyUser myUser=await _userRepository.getMyUser(event.MyUserId);
        MyUser new_user=myUser.copyWith(MessNo: event.MessNo);
        _userRepository.setUserData(new_user);
        emit(UpdateUserInfoSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserInfoFailure());
      }
    });
  }
}
