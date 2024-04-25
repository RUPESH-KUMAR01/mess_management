part of 'update_mess_info_bloc.dart';

abstract class UpdateMessInfoEvent extends Equatable {
  const UpdateMessInfoEvent();

  @override
  List<Object> get props => [];
}


class SetMessInfo extends UpdateMessInfoEvent{
  final Mess mess;
  final int add;
  const SetMessInfo(this.mess,{this.add=1});
}
class SetChangeInfo extends UpdateMessInfoEvent{
  final int iMessNo;
  final int fMessNo;

  SetChangeInfo(this.iMessNo,this.fMessNo);
}

class SetMessInfobyMessNo extends UpdateMessInfoEvent{
  final int MessNo;
  SetMessInfobyMessNo(this.MessNo);
}