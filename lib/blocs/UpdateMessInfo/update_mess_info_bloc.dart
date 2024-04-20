import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mess_repository/mess_repository.dart';

part 'update_mess_info_event.dart';
part 'update_mess_info_state.dart';

class UpdateMessInfoBloc extends Bloc<UpdateMessInfoEvent, UpdateMessInfoState> {
  MessRepository _messRepository;
  UpdateMessInfoBloc(
    MessRepository messRepository
  ) :_messRepository=messRepository, super(UpdateMessInfoInitial()) {
    on<UpdateMessInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
