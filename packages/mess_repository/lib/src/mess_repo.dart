

import 'package:mess_repository/src/models/mess.dart';

abstract class MessRepository{


  Future<Mess> CreateMess(Mess mess);
  Future<void> IncreaseMess(Mess mess);
  Future<List<Mess>> GetMess();
}