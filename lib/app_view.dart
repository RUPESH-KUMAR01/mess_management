

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/blocs/signin/sign_in_bloc.dart';
import 'package:mess_management/screens/user_authentication/welcomescreen.dart';
import 'package:mess_management/screens/user_home/homescreen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mess Management',
      theme: ThemeData.light(),
      home: 
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state.status==AuthenticationStatus.authenticated){

            return MultiBlocProvider(providers: [
              BlocProvider(create: 
            (context)=> SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository)),
            BlocProvider(
              create: (context)=>MyUserBloc(
                myUserRepository: context.read<AuthenticationBloc>().userRepository, 
                MyUserId: context.read<AuthenticationBloc>().state.user!.uid,
                )..add(GetMyUser(MyUserId: context.read<AuthenticationBloc>().state.user!.uid)),
            ),
            ], child: HomeScreen()
            ); 
            
          }else{
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}