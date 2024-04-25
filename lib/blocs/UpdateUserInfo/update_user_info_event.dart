part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}


class SetUserInfo extends UpdateUserInfoEvent{
  final Mess mess;
  final String MyUserId;
  const SetUserInfo(this.mess,this.MyUserId);
}

class SetUserBalance extends UpdateUserInfoEvent{
  final String MyUserId;
  final AddBalance;
  const SetUserBalance(this.MyUserId,this.AddBalance);
}

class SetUserInfobyMessNo extends UpdateUserInfoEvent{
  final String MyUserId;
  SetUserInfobyMessNo(this.MyUserId);
}

class SetChangeRequest extends UpdateUserInfoEvent{
  final String MyUserId;
  final bool _change;
  const SetChangeRequest(this.MyUserId,this._change);
}

class UserMessUpdate extends UpdateUserInfoEvent{
  final String MyUserId;
  final int MessNo;
  UserMessUpdate(this.MyUserId,this.MessNo);
}