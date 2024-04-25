import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_list/approval_list_bloc.dart';
import 'package:mess_management/blocs/Approval_user/approval_user_bloc.dart';
import 'package:mess_management/blocs/UpdateMessInfo/update_mess_info_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/User_List/user_list_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/mess_create/mess_create_bloc.dart';
import 'package:mess_management/screens/admin_home/DeallocateScreen.dart';
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
            MultiBlocProvider(providers: [
                BlocProvider<ApprovalListBloc>(create: (context)=>ApprovalListBloc()),
            BlocProvider(
              create: (context) => UpdateMessInfoBloc(FirebaseMessRepository())),
            BlocProvider(create: (context)=>ApprovalUserBloc()),
            BlocProvider(create: (context)=>UpdateUserInfoBloc(context.read<AuthenticationBloc>().userRepository))
            ], child: RequestApprove(),)
            ));
          }, child: Text('Approvals')),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context)=>
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UpdateMessInfoBloc(FirebaseMessRepository()),
                  ),
                  BlocProvider(
                    create: (context) => UserListBloc(context.read<AuthenticationBloc>().userRepository),
                  ),
                  BlocProvider(
                    create: (context) => UpdateUserInfoBloc(context.read<AuthenticationBloc>().userRepository),
                  )
                ],
                child: DeAllocate(),
              )
            ));
          }, child: Text("Deallocate"))
        ],)
    );
  }
}