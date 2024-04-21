import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if(state.status==MyUserStatus.success){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,child: Text('  Profile',style: TextStyle(fontSize: 15),),),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${state.user!.name}"),
                        SizedBox(height: 15,),
                        Text("Email: ${state.user!.email}"),
                        SizedBox(height: 15,),
                        Text("RollNo: ${state.user!.RollNo}"),
                        SizedBox(height: 15,),]
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.1,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Balance: ${state.user!.Balance}",style: TextStyle(fontSize: 20),)
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}