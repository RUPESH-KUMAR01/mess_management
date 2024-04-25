import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/UpdateMessInfo/update_mess_info_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/User_List/user_list_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class DeAllocate extends StatefulWidget {
  const DeAllocate({super.key});

  @override
  State<DeAllocate> createState() => _DeAllocateState();
}

class _DeAllocateState extends State<DeAllocate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deallocate'),
      ),
      body: BlocListener<UpdateMessInfoBloc, UpdateMessInfoState>(
        listener: (context, state) {
          if(state is UpdateMessSuccess){
            setState(() {
              context.read<UserListBloc>().add(GetUserList());
            });
          }
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListSuccess) {
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    MyUser user = state.users[index];
                    return Card(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("Name: ${user.name}"),
                              Text(
                                  "MessNo: ${user.Alloted ? user.MessNo.toString() : "Not Alloted"}")
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          user.Alloted
                              ? FilledButton(
                                  onPressed: () {
                                    context.read<UpdateUserInfoBloc>().add(
                              SetChangeRequest(
                                  context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user!
                                      .uid,
                                  false));
                                    context.read<UpdateUserInfoBloc>().add(SetUserInfobyMessNo(user.id));
                                    context.read<UpdateMessInfoBloc>().add(SetMessInfobyMessNo(user.MessNo));
                                  },
                                  child: Text('deallocate'))
                              : Text('Not Alloted')
                        ],
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
