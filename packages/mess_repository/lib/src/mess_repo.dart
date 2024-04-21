

import 'package:mess_repository/src/models/mess.dart';

abstract class MessRepository{

  Stream<List<Mess>?> get messes;
  Future<Mess> CreateMess(Mess mess);
  Future<void> SetMess(Mess mess);
  Future<List<Mess>> GetMess();
}