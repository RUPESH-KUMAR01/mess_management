import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/mess_create/mess_create_bloc.dart';
import 'package:mess_management/components/strings.dart';
import 'package:mess_management/components/textfield.dart';
import 'package:mess_repository/mess_repository.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _MessNo = TextEditingController();
  final _Capacity = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _createmess = false;
  String? _ErrorMsg;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MessCreateBloc, MessCreateState>(
      listener: (context, state) {
        if(state is CreateMessSuccess){
          Navigator.pop(context);
        }else if(state is CreateMessLoading){
          setState(() {
           _createmess=true;
        });
        }else if(state is CreateMessFailure){
          setState(() {
            _createmess=false;
            _ErrorMsg='Mess Already Exists';
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mess Creation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      child: MyTextField(
                        controller: _MessNo,
                        hintText: 'Mess Number',
                        errorMsg: _ErrorMsg,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Fill in this field';
                          }
                          if (!numberRexExp.hasMatch(val)) {
                            return 'Please Enter Only Numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      child: MyTextField(
                        controller: _Capacity,
                        hintText: 'Capacity',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Fill in this field';
                          }
                          if (!numberRexExp.hasMatch(val)) {
                            return 'Please Enter Only Numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !_createmess
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  Mess mess = Mess(
                                      MessNo: int.parse(_MessNo.text),
                                      Capacity: int.parse(_Capacity.text),
                                      Present: 0);
                                  context
                                      .read<MessCreateBloc>()
                                      .add(CreateMess(mess));
                                }
                              },
                              child: Text('Create'),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
