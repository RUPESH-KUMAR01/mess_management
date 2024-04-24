import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_user/approval_user_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/status_change/status_chang_bloc.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _change = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if(state is UpdateUserInfoSuccess){
          setState(() {
            _change=false;
          });
        }else if(state is UpdateUserInfoLoading){
          _change=true;
        }else{
          _change=false;
        }
      },
      child: BlocBuilder<StatusChangBloc, StatusChangState>(
        builder: (context, state) {
          if (state is ApprovalStatusSuccess) {
            if (state.approval.Pending) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pending"),
                  !_change?
                  FilledButton(
                      onPressed: () {
                        context.read<ApprovalUserBloc>().add(RequestRemoval(
                            context
                                .read<AuthenticationBloc>()
                                .state
                                .user!
                                .uid));
                        context.read<UpdateUserInfoBloc>().add(SetChangeRequest(
                            context.read<AuthenticationBloc>().state.user!.uid,
                            false));
                      },
                      child: Text('Remove Request')) : CircularProgressIndicator()
                ],
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Text(state.approval.Accepted
                        ? "Mess Changed"
                        : "Mess cannot be changed"),
                   !_change ? FilledButton(
                        onPressed: () {
                          context.read<UpdateUserInfoBloc>().add(
                              SetChangeRequest(
                                  context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user!
                                      .uid,
                                  false));
                        },
                        child: Text('New Request')) : CircularProgressIndicator()
                  ],
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
