import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mess_management/blocs/UpdateUserInfo/update_user_info_bloc.dart';
import 'package:mess_management/blocs/mess_list/mess_list_bloc.dart';
import 'package:mess_management/blocs/my_userbloc/my_user_bloc.dart';
import 'package:mess_management/screens/user_home/mess_change.dart';
import 'package:mess_management/screens/user_home/topup_screen.dart';
import 'package:mess_repository/mess_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if (state.status == MyUserStatus.success) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                  child: Text(
                    '  Profile',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${state.user!.name}",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Email: ${state.user!.email}",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "RollNo: ${state.user!.RollNo}",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Mess: ${state.user!.MessNo}",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Balance: ${state.user!.Balance}",
                              style: TextStyle(fontSize: 20),
                            )
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return BlocProvider<UpdateUserInfoBloc>.value(
                                value: context.read<UpdateUserInfoBloc>(),
                                child: topup_screen(),
                              );
                            }));
                          },
                          child: Text("Top Up"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<MyUserBloc>.value(
                                    value: context.read<MyUserBloc>(),
                                  ),
                                  BlocProvider(
                                    create: (context) => MessListBloc(messRepository: FirebaseMessRepository()),
                                  ),
                                ],
                                child: Mess_change(),
                              );
                            }));
                          },
                          child: Text("Mess Change"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
