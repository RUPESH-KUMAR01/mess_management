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
  Future<List<Mess>> GetMess() async {
    // TODO: implement GetMess
     try{
    List<Mess> messes=[];
    final pro=await MessCollection.get();
    pro.docs.forEach((element) {
      return messes.add(Mess.fromEntity(MessEntity.fromDocument(element.data())));
    });
    return messes;
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> SetMess(Mess mess) async {
    try {
      await MessCollection.doc(mess.MessNo.toString()).update(mess.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<Mess>?> get messes{
    return MessCollection.snapshots()
    .map((SnapShot) =>SnapShot.docs
    .map((document) => Mess.fromEntity(MessEntity.fromDocument(document.data()))).toList());
  }
  
  @override
  Future<Mess> MessInfo(int MessNo) async {
    try {
      return await MessCollection.doc(MessNo.toString()).get().then((document) => Mess.fromEntity(MessEntity.fromDocument(document.data()!)));
    } catch (e) {
      e.toString();
      rethrow;
    }
  }
  
}