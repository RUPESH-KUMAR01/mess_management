import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/authentication/authentication_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/screens/user_home/a_homescreen.dart';
import 'package:mess_management/screens/user_home/u_homescreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if (state.user?.isAdmin ?? false) {
          return BlocProvider<MyUserBloc>(
            create: (context) => MyUserBloc(
                myUserRepository:
                    context.read<AuthenticationBloc>().userRepository,
                    MyUserId: context.read<AuthenticationBloc>().state.user!.uid)
              ..add(GetMyUser(
                  MyUserId:
                      context.read<AuthenticationBloc>().state.user!.uid)),
            child: AHomeScreen(),
          );
        } else {
          return MultiBlocProvider(
            providers: [
              BlocProvider<MyUserBloc>(
                create: (context) => MyUserBloc(
                    myUserRepository:
                        context.read<AuthenticationBloc>().userRepository,
                        MyUserId: context.read<AuthenticationBloc>().state.user!.uid)
                  ..add(GetMyUser(
                      MyUserId:
                          context.read<AuthenticationBloc>().state.user!.uid)),
              ),
            ],
            child: U_HomeScreen(),
          );
        }
      },
    );
  }
}
