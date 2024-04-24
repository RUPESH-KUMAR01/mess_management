


import 'package:approval_repository/src/entities/entities.dart';

class Approval{
  String id;
  int iMessNo;
  int fMessNo;
  bool Accepted;
  bool Pending;

  Approval({
    required this.id,
    required this.fMessNo,
    required this.iMessNo,
    this.Accepted=false,
    this.Pending=true});


  static final empty=Approval(
    id: '',
     fMessNo: 0,
      iMessNo: 0,
      Accepted: false,
      Pending: true);

  Approval copyWith({
  String? id,
  int? iMessNo,
  int? fMessNo,
  bool? Accepted,
  bool? Pending,
  }){
    return Approval(id: id??this.id, 
    fMessNo: fMessNo??this.fMessNo, 
    iMessNo: iMessNo??this.iMessNo,
    Accepted: Accepted??this.Accepted,
    Pending: Pending??this.Pending
    );
  }

  bool get isEmpty => this==Approval.empty;
  bool get isNotEmpty=> this!=Approval.empty;


  ApprovalEntity toEntity(){
    return ApprovalEntity(
    id: id, 
    fMessNo: fMessNo,
     iMessNo: iMessNo,
     Accepted: Accepted,
     Pending: Pending);
  }

  static Approval fromEntity(ApprovalEntity entity){
    return Approval(
      id: entity.id,
       fMessNo: entity.fMessNo,
        iMessNo: entity.iMessNo,
        Accepted: entity.Accepted,
        Pending: entity.Pending);
  }

  @override
  String toString(){
    return '''ApprovalEntity{
      id: $id,
       fMessNo: $fMessNo,
        iMessNo: $iMessNo,
        Accepted:$Accepted,
        Pending:$Pending}''';
  }
}