// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mess_repository/src/entities/mess_entity.dart';

class Mess {
  int MessNo;
  int Capacity;
  int Present;
  Mess({
    required this.MessNo,
    required this.Capacity,
    required this.Present,
  });
  static final empty=Mess(
     MessNo: 0,
    Capacity: 0,
     Present: 0);

    Mess copyWith({
      String? Messid,
      int? MessNo,
      int? Capacity,
      int? Present
    }){
      return Mess(
         MessNo: MessNo??this.MessNo,
          Capacity: Capacity??this.Capacity,
           Present: Present??this.Present);
    }


    bool get isEmpty =>this==Mess.empty;
    bool get isNotEmpty => this!=Mess.empty;



  MessEntity toEntity(){
    return MessEntity(
      MessNo:MessNo,
      Capacity:Capacity,
      Present:Present
    );
  }

  static Mess fromEntity(MessEntity entity){
    return Mess(
       MessNo: entity.MessNo,
        Capacity: entity.Capacity,
         Present: entity.Present);
  }
  @override
  String toString(){
    return '''MessEntity:{
      MessNo:$MessNo,
      Capacity:$Capacity,
      Present:$Present
    }''';
  }
}
