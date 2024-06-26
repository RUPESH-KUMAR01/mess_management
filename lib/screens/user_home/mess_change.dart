import 'package:approval_repository/approval_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_user/approval_user_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/mess_list/mess_list_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/screens/user_home/Progress_screen.dart';
import 'package:mess_repository/mess_repository.dart';

class Mess_change extends StatefulWidget {
  const Mess_change({super.key});

  @override
  State<Mess_change> createState() => _Mess_changeState();
}

class _Mess_changeState extends State<Mess_change> {
  int? _currentMess;
  Mess? _selectedMess;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mess Change"),backgroundColor: Colors.blueAccent,),
      body: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
        if(state.status==MyUserStatus.success){  
      _currentMess=state.user!.MessNo;
      if(state.user!.change==false){
          return BlocBuilder<MessListBloc, MessListState>(
          builder: (context, state) {
            if (state is MessListSuccess) {
              return Column(
                children:[
                  const SizedBox(height: 10,),
                   SizedBox(
                    child:Text(
                      "Current Mess: ${_currentMess}"
                    )),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.messes.length,
                      itemBuilder: (context,i) {
                        if(state.messes[i].Present<state.messes[i].Capacity && state.messes[i].MessNo!=_currentMess){
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
                            Approval _approval=Approval(
                              id: context.read<AuthenticationBloc>().state.user!.uid ,
                               fMessNo: int.parse(_selectedMess!.MessNo.toString()),
                                iMessNo: int.parse(_currentMess.toString()));
                                context.read<UpdateUserInfoBloc>().add(
                                  SetChangeRequest(context.read<AuthenticationBloc>().state.user!.uid,true)
                                );
                            context.read<ApprovalUserBloc>().add(
                              MessChangerequest(_approval)
                            );
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
        );
      }else{
        return ProgressScreen();
      }
        }else{
      return CircularProgressIndicator();
        }
      
      }),
    );}
Container CustomListTile(int i, MessListSuccess state, BuildContext context) {
    return Container(
                        color: (_selectedMess?.MessNo == state.messes[i].MessNo)
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
                                  Column(
                                    children: [
                                      Text("Present: ${state.messes[i].Present}"),
                                    const SizedBox(width: 15,),
                                  Text("Capacity: ${state.messes[i].Capacity}")
                                    ],
                                  ),

                                ],
                              ),),
                              Expanded(
                                child: TextButton(onPressed:() {
                                setState(() {
                                  if (_selectedMess != i) {
                                    if(state.messes[i].Present<state.messes[i].Capacity && _currentMess!=state.messes[i].MessNo)
                                    _selectedMess = state.messes[i];
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
                        color: (_selectedMess?.MessNo == state.messes[i].MessNo)
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
                                  Column(
                                    children: [
                                      Text("Present: ${state.messes[i].Present}"),
                                                                        const SizedBox(width: 15,),
                                  Text("Capacity: ${state.messes[i].Capacity}")
                                    ],
                                  ),
                                ],
                              ),),
                            ] 
                          ),
                        ),
                      );
  }

}