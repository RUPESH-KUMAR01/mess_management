import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_list/approval_list_bloc.dart';
import 'package:mess_management/blocs/mess_create/mess_create_bloc.dart';
import 'package:mess_management/screens/admin_home/RequestApprove.dart';
import 'package:mess_management/screens/admin_home/mess_create.dart';
import 'package:mess_repository/mess_repository.dart';

class AHomeScreen extends StatelessWidget {
  const AHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Screen'),titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black,),
        body:Column(children: [
          TextButton(onPressed:(){Navigator.push(context,MaterialPageRoute<void>(
            builder: (BuildContext context) => 
            BlocProvider<MessCreateBloc>(create: (context)=>MessCreateBloc(messRepository: FirebaseMessRepository()),
            child:CreateScreen(),)));
          }, child: Text('Create Mess')),
          TextButton(onPressed:(){Navigator.push(context,MaterialPageRoute<void>(
            builder: (BuildContext context) => 
            BlocProvider<ApprovalListBloc>(create: (context)=>ApprovalListBloc(),
            child:RequestApprove(),)));
          }, child: Text('Approvals')),
        ],)
    );
  }
}