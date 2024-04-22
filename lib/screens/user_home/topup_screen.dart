import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/components/strings.dart';
import 'package:mess_management/components/textfield.dart';

class topup_screen extends StatefulWidget {
  const topup_screen({super.key});

  @override
  State<topup_screen> createState() => _topup_screenState();
}

class _topup_screenState extends State<topup_screen> {
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool cir = false;
  String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top Up")),
      body: BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
        listener: (context, state) {
          if(state is UpdateUserInfoSuccess){
            Navigator.pop(context);
          }else if(state is UpdateUserInfoLoading){
            cir=false;
          }else{
            cir=true;
            _errorMsg="Try Again";
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                  controller: amountController,
                  hintText: "Amount",
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  errorMsg: _errorMsg,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter amount";
                    }
                    if (!numberRexExp.hasMatch(val)) {
                      return 'Please Enter Valid Amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                !cir
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<UpdateUserInfoBloc>().add(SetUserBalance(
                                context.read<AuthenticationBloc>().state.user!.uid
                                , int.parse(amountController.text)));
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                            child: Text(
                              'Add',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
