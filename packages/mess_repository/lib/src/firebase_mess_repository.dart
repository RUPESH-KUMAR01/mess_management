import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_repository/mess_repository.dart';
import 'package:mess_repository/src/entities/mess_entity.dart';
import 'package:mess_repository/src/models/mess.dart';

class FirebaseMessRepository implements MessRepository{
  
  final MessCollection=FirebaseFirestore.instance.collection('mess');
  
  @override
  Future<Mess> CreateMess(Mess mess) async {

    try{
      bool ok=false;
      await MessCollection.doc(mess.MessNo.toString()).get().then((value) => value.exists?ok=true:ok=false);
      if(ok){
        mess.MessNo=-1;
        return mess;
      }
      else{
      await MessCollection.doc(mess.MessNo.toString()).set(mess.toEntity().toDocument());
      return mess;
      }
    }
    catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Mess>> GetMess() {
    // TODO: implement GetMess
    try {
      return MessCollection
      .snapshots()
      .map(
        (snapShot) =>
         snapShot.docs
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
      await MessCollection.doc(mess.MessNo.toString()).update(mess.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
}