import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_repository/mess_repository.dart';
import 'package:mess_repository/src/entities/mess_entity.dart';
import 'package:mess_repository/src/models/mess.dart';
import 'package:uuid/uuid.dart';

class FirebaseMessRepository implements MessRepository{
  
  final MessCollection=FirebaseFirestore.instance.collection('mess');
  
  @override
  Future<Mess> CreateMess(Mess mess) async {

    try{
      mess.Messid=const Uuid().v1();
      await MessCollection.doc(mess.Messid).set(mess.toEntity().toDocument());
      return mess;
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Mess>> GetMess() async {
    // TODO: implement GetMess
    try {
      return MessCollection
      .get()
      .then(
        (value) =>
         value.docs
         .map(
          (e) => Mess.fromEntity(MessEntity.fromDocument(e.data())))
          .toList()
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> IncreaseMess(Mess mess) async {
    try {
      await MessCollection.doc(mess.Messid).update(mess.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
}