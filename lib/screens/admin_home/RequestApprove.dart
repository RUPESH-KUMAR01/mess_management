import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/Approval_list/approval_list_bloc.dart';

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
      appBar: AppBar(title: Text('Approval Page'),),
      body: BlocBuilder<ApprovalListBloc, ApprovalListState>(
        builder: (context, state) {
          if(state is ApprovalListSuccess){
            return ListView.builder(
              itemCount: state.ApprovalList.length,
              itemBuilder:(context, index) {
                return ListTile(
                  title: Text(state.ApprovalList![index].id),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
          
        },
      ),
    );
  }
}