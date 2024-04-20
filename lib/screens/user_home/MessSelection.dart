import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/mess_list/mess_list_bloc.dart';

class MessSelection extends StatefulWidget {
  const MessSelection({super.key});

  @override
  State<MessSelection> createState() => _MessSelectionState();
}

class _MessSelectionState extends State<MessSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<MessListBloc, MessListState>(
        builder: (context, state) {
          if(state is MessListSuccess){
            return ListView.builder(
                  itemCount: state.messes.length,
                  itemBuilder:(context,int i){
                    return ListTile(
                      title: Text(state.messes[i].MessNo.toString()),
                    );
                  },
                  );
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}