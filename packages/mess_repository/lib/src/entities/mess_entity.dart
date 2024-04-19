// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessEntity {
  String Messid;
  int MessNo;
  int Capacity;
  int Present;
  MessEntity({
    required this.Messid,
    required this.MessNo,
    required this.Capacity,
    required this.Present,
  });

  Map<String,Object?> toDocument(){
    return {
      'Messid':Messid,
      'MessNo':MessNo,
      'Capacity':Capacity,
      'Present':Present
    };
  }


  static MessEntity fromDocument(Map<String,Object?> doc){
    return MessEntity(
      Messid: doc['Messid'] as String, 
      MessNo: doc['MessNo'] as int, 
      Capacity: doc['Capacity'] as int,
      Present: doc['Present'] as int);
  }
  @override
  List<Object?> get props =>[Messid,MessNo,Capacity,Present];

  @override
  String toString(){
    return '''MessEntity:{
      Messid:$Messid,
      MessNo:$MessNo,
      Capacity:$Capacity,
      Present:$Present
    }''';
  }
}
