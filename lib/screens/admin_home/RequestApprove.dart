import 'package:approval_repository/approval_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_list/approval_list_bloc.dart';
import 'package:mess_management/blocs/Approval_user/approval_user_bloc.dart';
import 'package:mess_management/blocs/UpdateMessInfo/update_mess_info_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';

class RequestApprove extends StatefulWidget {
  const RequestApprove({super.key});

  @override
  State<RequestApprove> createState() => _RequestApproveState();
}

class _RequestApproveState extends State<RequestApprove> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ApprovalListBloc>().add(GetApprovalList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval Page'),
      ),
      body: BlocListener<ApprovalUserBloc, ApprovalUserState>(
        listener: (context, state) {
          if(state is ApprovalUserSuccess){
            setState(() {
              context.read<ApprovalListBloc>().add(GetApprovalList());
            });
          }
        },
        child: BlocBuilder<ApprovalListBloc, ApprovalListState>(
          builder: (context, state) {
            if (state is ApprovalListSuccess) {
              return ListView.builder(
                itemCount: state.ApprovalList.length,
                itemBuilder: (context, index) {
                  Approval app = state.ApprovalList[index];
                  return Card(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('Intial Mess: ${app.iMessNo}'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Final Mess: ${app.fMessNo}')
                          ],
                        ),
                        app.Pending
                            ? Row(
                                children: [
                                  FilledButton(
                                      onPressed: () {
                                        Approval approval = app.copyWith(
                                            Accepted: true, Pending: false);
                                        context.read<UpdateMessInfoBloc>().add(
                                            SetChangeInfo(
                                                app.iMessNo, app.fMessNo));
                                        context.read<UpdateUserInfoBloc>().add(
                                            UserMessUpdate(
                                                app.id, app.fMessNo));
                                        context
                                            .read<ApprovalUserBloc>()
                                            .add(SetRequest(approval));
                                      },
                                      child: Text("Accept")),
                                  FilledButton(
                                      onPressed: () {
                                        Approval approval = app.copyWith(
                                            Accepted: false, Pending: false);
                                        context
                                            .read<ApprovalUserBloc>()
                                            .add(SetRequest(approval));
                                      },
                                      child: Text("Reject"))
                                ],
                              )
                            : Text(app.Accepted ? "Accepted" : "Rejected")
                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
