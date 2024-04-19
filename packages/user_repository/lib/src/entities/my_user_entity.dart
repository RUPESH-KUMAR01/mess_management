import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable{
  final String id;
  final String email;
  final String name;
  final String RollNo;
  final bool Alloted;
  final int Balance;
  final int MessNo;
  final String Messid;
  final bool isAdmin;


  const MyUserEntity({
    required this.id, 
    required this.email, 
    required this.name, 
    required this.RollNo,
    this.Alloted=false,
    this.Balance=0,
    required this.MessNo,
    required this.Messid,
    this.isAdmin=false
    });

  Map<String,Object> toDocument(){
    return {
      'id':id,
      'email':email,
      'name':name,
      'RollNo':RollNo,
      'Alloted':Alloted,
      'Balance':Balance,
      'isAdmin':isAdmin,
      'Messid':Messid,
      'MessNo':MessNo
    };
  }

  static MyUserEntity fromDocument(Map<String,dynamic> doc){
    return MyUserEntity(
      id: doc['id'] as String,
     email: doc['email'] as String,
     name: doc['name'] as String,
     RollNo: doc['RollNo'] as String,
     Alloted: doc['Alloted'] as bool,
     Balance: doc['Balance'] as int, 
     Messid: doc['Messid'] as String,
     MessNo: doc['MessNo'] as int,
     isAdmin: doc['isAdmin'] as bool
     );
  }
  @override
  String toString() {
    return '''UserEntity{
      id:$id,
      email:$email,
      name:$name,
      RollNo:$RollNo,
      Alloted:$Alloted,
      Balance:$Balance,
      MessNo:$MessNo,
      Messid:$Messid,
      isAdmin:$isAdmin
    }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name,RollNo,Alloted,Balance,MessNo,Messid,isAdmin];
}