
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/blocs/signin/sign_in_bloc.dart';

class U_HomeScreen extends StatelessWidget {
  const U_HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Home Screen'),
      backgroundColor: Colors.indigoAccent,
      actions: [IconButton(onPressed: (){
        context.read<SignInBloc>().add(SignOutRequired());
      }, icon: Icon(Icons.logout))],
      ),
      body:
      Container(
        child: BlocBuilder<MyUserBloc,MyUserState>(
          builder:(context,State){
            if(State.status==MyUserStatus.success){
              return Row(
                children: [
                  State.user!.Alloted ? Text(' Alloted'): Text('Not Alloted'),
                  
                ],
              );
            }else{
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } ),
      )
    );
  }
}