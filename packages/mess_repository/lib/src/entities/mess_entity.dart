// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessEntity {
  int MessNo;
  int Capacity;
  int Present;
  MessEntity({
    required this.MessNo,
    required this.Capacity,
    required this.Present,
  });

  Map<String,Object?> toDocument(){
    return {
      'MessNo':MessNo,
      'Capacity':Capacity,
      'Present':Present
    };
  }


  static MessEntity fromDocument(Map<String,Object?> doc){
    return MessEntity(
      MessNo: doc['MessNo'] as int, 
      Capacity: doc['Capacity'] as int,
      Present: doc['Present'] as int);
  }
  @override
  List<Object?> get props =>[MessNo,Capacity,Present];

  @override
  String toString(){
    return '''MessEntity:{
      MessNo:$MessNo,
      Capacity:$Capacity,
      Present:$Present
    }''';
  }
}
