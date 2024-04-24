import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entites.dart';

class MyUser extends Equatable{
  final String id;
  final String email;
  final String name;
  final String RollNo;
  final bool Alloted;
  final int Balance;
  final int MessNo;
  final bool isAdmin;
  final bool change;

  const MyUser({
    required this.id, 
    required this.email, 
    required this.name,
    required this.RollNo,
    this.Alloted=false,
    this.Balance=0,
    required this.MessNo,
    this.isAdmin=false,
    this.change=false});
  static const empty=MyUser(
    id: '',
    email: '',
    name: '',
    RollNo:'',
    Alloted: false,
    Balance: 0,
    MessNo: 0,
    isAdmin: false,
    change: false);

  MyUser copyWith({
  String? id,
  String? email,
  String? name,
  String? RollNo,
  bool? Alloted,
  int? Balance,
  int? MessNo,
  bool? isAdmin,
  bool? change
  }){
    return MyUser(
      id: id ?? this.id,
       email: email ?? this.email,
        name: name ?? this.name,
        RollNo:RollNo??this.RollNo,
        Alloted: Alloted??this.Alloted,
        Balance: Balance??this.Balance,
        MessNo: MessNo??this.MessNo,
        isAdmin: isAdmin??this.isAdmin,
        change: change??this.change
         );
  }

  bool get isEmpty => this==MyUser.empty;

  bool get isNotEMpty => this!=MyUser.empty;


  MyUserEntity toEntity(){
    return MyUserEntity(
      id:id,
      email:email,
      name:name,
      RollNo:RollNo,
      Alloted:Alloted,
      Balance: Balance,
      MessNo: MessNo,
      isAdmin: isAdmin,
      change: change
    );
  }

  static  MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      id: entity.id,
       email: entity.email, 
       name: entity.name,
       RollNo: entity.RollNo,
       Alloted: entity.Alloted,
       Balance: entity.Balance,
       MessNo: entity.MessNo,
       isAdmin: entity.isAdmin,
       change: entity.change);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name,RollNo,Alloted,Balance,MessNo,isAdmin,change];
}