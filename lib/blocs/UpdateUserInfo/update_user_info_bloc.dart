import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
 UserRepository _userRepository;
  UpdateUserInfoBloc(UserRepository userRepository) :
  _userRepository=userRepository
  , super(UpdateUserInfoInitial()) {
    on<UpdateUserInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
