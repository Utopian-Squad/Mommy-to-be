import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/user_list/bloc/bloc.dart';
import 'package:client/src/user_list/bloc/user_list_event.dart';
import 'package:client/src/user_list/models/user_args.dart';
import 'package:client/src/user_list/screens/user_detail.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListScreen extends StatelessWidget {
  static const String routeName = "/userScreen";
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserListBloc>(context).add(UserListEvent([]));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text("Users List"),
      ),
      drawer: NavigationDrawerWidget(),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          return (authState is AuthenticationAuthenticated)
              ? BlocBuilder<UserListBloc, UserListState>(
                  builder: (context, userListState) {
                    print(userListState);
                    if (userListState is UserListStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (userListState is UserListStateLoaded) {
                      return (userListState is UserListStateLoading)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: userListState.users.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return (userListState.users[index].id !=
                                          authState.user?.id)
                                      ? Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    UserDetails.routeName,
                                                    arguments: UserArguments(
                                                        user: userListState
                                                            .users[index]));
                                              },
                                              child: Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                margin: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.025),
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 3,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundImage: NetworkImage(
                                                      '${Constants.imageBaseUrl}images/user/${userListState.users[index].image}'),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: userListState
                                                            .users[index]
                                                            .role["roleName"] ==
                                                        'admin'
                                                    ? Colors.pink[400]
                                                    : Colors.purple,
                                                child: Text(
                                                    '${authState.user?.id == userListState.users[index].id ? 'You' : userListState.users[index].role["roleName"]}'),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // Navigator.of(context).pushNamed(
                                                //     RouteGenerator
                                                //         .profileScreen);
                                              },
                                              child: Container(
                                                height: 130,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                margin: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.025),
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 3,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundImage: NetworkImage(
                                                      '${Constants.imageBaseUrl}images/user/${userListState.users[index].image}'),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: userListState
                                                            .users[index]
                                                            .role["roleName"] ==
                                                        'admin'
                                                    ? Colors.pink[400]
                                                    : Colors.purple,
                                                child: Text(
                                                    '${authState.user?.id == userListState.users[index].id ? 'you' : userListState.users[index].role["roleName"]}'),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            );
                    }
                    return Container();
                  },
                )
              : Container();
        },
      ),
    );
  }
}
