import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/UpdateMessInfo/update_mess_info_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/mess_list/mess_list_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/blocs/signin/sign_in_bloc.dart';
import 'package:mess_management/screens/user_home/MessSelection.dart';
import 'package:mess_management/screens/user_home/ProfileScreen.dart';
import 'package:mess_repository/mess_repository.dart';

class U_HomeScreen extends StatelessWidget {
  const U_HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Home Screen'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
                    if (state.status == MyUserStatus.success) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: state.user!.Alloted
                ? ProfileScreen()
                : MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => UpdateUserInfoBloc(context
                            .read<AuthenticationBloc>()
                            .userRepository),
                      ),
                      BlocProvider(
                        create: (context) => UpdateMessInfoBloc(FirebaseMessRepository()),
                      ),
                      BlocProvider(create: (context)=>MessListBloc(messRepository: FirebaseMessRepository()))
                    ],
                    child: MessSelection(),
                  ),
        );
                    } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
                    }
                  }));
  }
}
