import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/UpdateMessInfo/update_mess_info_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/mess_list/mess_list_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/screens/user_home/ProfileScreen.dart';

class MessSelection extends StatefulWidget {
  const MessSelection({super.key});

  @override
  State<MessSelection> createState() => _MessSelectionState();
}

class _MessSelectionState extends State<MessSelection> {
  int? _selectedMess;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
  builder: (context, state) {
  if(state.status==MyUserStatus.success){  
    if(state.user!.Alloted==false){
        return BlocListener<UpdateMessInfoBloc, UpdateMessInfoState>(
      listener: (context, state) {
        if(state is UpdateMessTry){
          setState(() {
            _selectedMess=null;
          });
          SnackBar(content: Text('Try Again'),
          duration: Durations.medium4,);
        }else if(state is UpdateMessSuccess){

        }
      },
      child: BlocBuilder<MessListBloc, MessListState>(
        builder: (context, state) {
          if (state is MessListSuccess) {
            return Column(
              children:[ 
                Expanded(
                  child: ListView.builder(
                    itemCount: state.messes.length,
                    itemBuilder: (context, int i) {
                      if(state.messes[i].Present<state.messes[i].Capacity){
                        return CustomListTile(i, state, context);
                      }else{
                        return CustomListTile2(i, state, context);
                      }
                        
                    }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child:_selectedMess != null
                    ? TextButton(
                        onPressed: () {
                          context
                              .read<UpdateMessInfoBloc>()
                              .add(SetMessInfo(state.messes[_selectedMess!]));
                          context.read<UpdateUserInfoBloc>().add(SetUserInfo(state.messes[_selectedMess!], context.read<AuthenticationBloc>().state.user!.uid));
                        },
                        child: Text('Confirm'))
                    : Text('Please Select Mess')
            )
            ]
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
    }else{
      return ProfileScreen();
    }
  }else{
    return Container(
      child: Text('Some Error'),
    );
  }
    
  },
);
  }

  Container CustomListTile(int i, MessListSuccess state, BuildContext context) {
    return Container(
                        color: (_selectedMess == i)
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 5,),
                              Text(state.messes[i].MessNo.toString()),
                              SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.5,
                              child: Row(
                                children: [
                                  Text("Present: ${state.messes[i].Present}"),
                                  const SizedBox(width: 15,),
                                  Text("Capacity: ${state.messes[i].Capacity}")
                                ],
                              ),),
                              Expanded(
                                child: TextButton(onPressed:() {
                                setState(() {
                                  if (_selectedMess != i) {
                                    if(state.messes[i].Present<state.messes[i].Capacity)
                                    _selectedMess = i;
                                  } else {
                                    _selectedMess = null;
                                  }
                                });
                                                              }, child: Text('Select'),),
                              )
                            ] 
                          ),
                        ),
                      );
  }

   Container CustomListTile2(int i, MessListSuccess state, BuildContext context) {
    return Container(
                        color: (_selectedMess == i)
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 5,),
                              Text(state.messes[i].MessNo.toString()),
                              SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.5,
                              child: Row(
                                children: [
                                  Text("Present: ${state.messes[i].Present}"),
                                  const SizedBox(width: 15,),
                                  Text("Capacity: ${state.messes[i].Capacity}")
                                ],
                              ),),
                            ] 
                          ),
                        ),
                      );
  }
}




