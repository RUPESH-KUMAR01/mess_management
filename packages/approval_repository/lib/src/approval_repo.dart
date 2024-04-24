import 'package:approval_repository/src/models/approval.dart';

abstract class ApprovalRepository{
  

  Stream<List<Approval>> get approvals;
  Stream<Approval> ApprovalStatus(String MyUserId);
  Future<void> CreateApproval(Approval approval);
  Future<void> setApproval(Approval approval);
  Future<Approval> Status(String MyUserId);
  Future<List<Approval>> GetApprovals();
  Future<void> Remove(String MyUserId);
}