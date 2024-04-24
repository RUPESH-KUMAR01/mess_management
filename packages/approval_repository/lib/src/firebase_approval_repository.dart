


import 'dart:developer';

import 'package:approval_repository/src/approval_repo.dart';
import 'package:approval_repository/src/entities/approval_entity.dart';
import 'package:approval_repository/src/models/approval.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApprovalRepository implements ApprovalRepository{

  final ApproveCollection=FirebaseFirestore.instance.collection('Approval');

  @override
  Future<void> CreateApproval(Approval approval) async{
    await ApproveCollection.doc(approval.id).set(approval.toEntity().toDocument());
  }

  @override
  Future<List<Approval>> GetApprovals() async {
    List<Approval> approvals=[];
    try {
      final pro=await ApproveCollection.get();
      pro.docs.forEach((element) {
        return approvals.add(Approval.fromEntity(ApprovalEntity.fromDocument(element.data())));
      });
      return approvals;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  // TODO: implement approvals
  Stream<List<Approval>> get approvals {
    return ApproveCollection.snapshots().
    map((event) => event.docs.
    map((e) => Approval.fromEntity(ApprovalEntity.fromDocument(e.data()))).toList()
    );
  }
  @override
  Future<void> setApproval(Approval approval) async {
    try {
      await ApproveCollection.doc(approval.id).update(approval.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
    Stream<Approval> ApprovalStatus(String MyUserId){
      return ApproveCollection.doc(MyUserId).
      snapshots().map(
        (event) => Approval.fromEntity(ApprovalEntity.fromDocument(event.data()!)
        )
      );
    }
    
      @override
      Future<Approval> Status(String MyUserId) {
        try {
          return ApproveCollection.doc(MyUserId).get().then((value){
            return Approval.fromEntity(ApprovalEntity.fromDocument(value.data()!));
          });
        } catch (e) {
          log(e.toString());
          rethrow;
        }
      }
      
        @override
        Future<void> Remove(String MyUserId) async {
          try {
            await ApproveCollection.doc(MyUserId).delete();
          } catch (e) {
            log(e.toString());
            rethrow;
          }
        }
}