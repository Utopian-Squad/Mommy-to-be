import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/role/bloc/bloc.dart';
import 'package:client/src/user_list/bloc/bloc.dart';
import 'package:client/src/user_list/models/user_args.dart';
import 'package:client/src/user_list/screens/users_screen.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatefulWidget {
  final UserArguments args;
  UserDetails({required this.args});
  static const String routeName = "/userDetails";

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String valueStr = '';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RoleBloc>(context).add(RoleLoad());
    print("object");
    print(widget.args.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.pink[400],
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(
                  '${Constants.imageBaseUrl}images/user/${widget.args.user?.image}',
                  scale: 1.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      '${widget.args.user?.firstName} ${widget.args.user?.lastName}',
                      style: TextStyle(fontSize: 26, color: Colors.pink),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.verified_user,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      '${widget.args.user?.role["roleName"]}',
                      style: TextStyle(fontSize: 22, color: Colors.pink),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      '${widget.args.user?.phoneNumber}',
                      style: TextStyle(fontSize: 16, color: Colors.pink),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<RoleBloc, RoleState>(
              builder: (context, roleState) {
                if (roleState is RolesLoadSuccess) {
                  return ListView.builder(
                    itemCount: roleState.roles.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        activeColor: roleState.roles[index].roleName ==
                                widget.args.user?.role
                            ? Colors.green
                            : Colors.grey,
                        title: Text(roleState.roles[index].roleName),
                        value: roleState.roles[index].roleName,
                        groupValue: valueStr,
                        onChanged: (dynamic value) {
                          setState(() {
                            valueStr = value;
                          });
                        },
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, userState) {
              return (userState is AuthenticationAuthenticated)
                  ? BlocBuilder<RoleBloc, RoleState>(
                      builder: (context, roleState) {
                        return roleState is RolesLoadSuccess
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pink[400]),
                                child: Text('Update Role'),
                                onPressed: () {
                                  roleState.roles.forEach((element) {
                                    if (element.roleName == valueStr) {
                                      BlocProvider.of<UserListBloc>(context)
                                          .add(UpdateUserEvent(
                                              userId: widget.args.user?.id,
                                              roleId: element.id));

                                      Navigator.pushNamed(
                                          context, UsersListScreen.routeName);
                                    }
                                  });
                                })
                            : Container();
                      },
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
