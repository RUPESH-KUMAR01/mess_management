class ApprovalEntity{
  String id;
  int iMessNo;
  int fMessNo;
  bool Accepted;
  bool Pending;

  ApprovalEntity({
    required this.id,
    required this.fMessNo,
    required this.iMessNo,
    this.Accepted=false,
    this.Pending=true});

    Map<String,Object?> toDocument(){
      return {
        'id':id,
        'iMessNo':iMessNo,
        'fMessNo':fMessNo,
        'Accepted':Accepted,
        'Pending':Pending
      };
    }

    static ApprovalEntity fromDocument(Map<String,Object?> doc){
      return ApprovalEntity(
        id: doc['id'] as String,
         fMessNo: doc['fMessNo'] as int,
          iMessNo: doc['iMessNo'] as int,
          Accepted: doc['Accepted'] as bool,
          Pending: doc['Pending'] as bool);
    }

    @override
    List<Object?> get props =>[id,fMessNo,iMessNo,Accepted,Pending];
}