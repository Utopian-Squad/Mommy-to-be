import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/role/role_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleManage extends StatelessWidget {
  static const String routeName = "/routeManage";
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RoleBloc>(context)..add(RoleLoad());
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, roleState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink[400],
            title: Text('Role Management'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoleDetails.routeName,
                        arguments: RoleArgument(create: true));
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          drawer: NavigationDrawerWidget(),
          body: Column(
            children: [
              // Container(
              //   height: 180,
              //   padding: EdgeInsets.all(15.0),
              //   color: Colors.white,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: <Widget>[
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text('Roles Available',
              //               style: TextStyle(
              //                 fontSize: 16,
              //               )),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 2.0,
              //       ),
              //       BlocBuilder<RoleBloc, RoleState>(
              //         builder: (context, roleState) {
              //           if (roleState is RoleLoading) {
              //             return Center(child: CircularProgressIndicator());
              //           } else if (roleState is RolesLoadSuccess) {
              //             return Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 RichText(
              //                   text: TextSpan(
              //                     children: <TextSpan>[
              //                       TextSpan(
              //                           text: '${roleState.roles.length} ',
              //                           style: TextStyle(
              //                             fontSize: 44,
              //                             fontWeight: FontWeight.bold,
              //                             color: Colors.pink[400],
              //                           )),
              //                       TextSpan(
              //                           text: 'Roles',
              //                           style: TextStyle(
              //                               fontSize: 36,
              //                               fontWeight: FontWeight.w400,
              //                               color: Colors.black)),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             );
              //           } else {
              //             return Container();
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: BlocBuilder<RoleBloc, RoleState>(
                  builder: (context, roleState) {
                    if (roleState is RoleLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (roleState is RolesLoadSuccess) {
                      return ListView.builder(
                          itemCount: roleState.roles.length,
                          itemBuilder: (context, index) {
                            final item = roleState.roles[index].roleName;
                            return Dismissible(
                              background: Container(
                                color: Colors.pink[400],
                              ),
                              key: Key(item),
                              onDismissed: (direction) {
                                BlocProvider.of<RoleBloc>(context)
                                    .add(RoleDelete(roleState.roles[index]));
                                print(
                                    '${roleState.roles[index].id} dissmissed');
                              },
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  dense: true,
                                  leading: Icon(
                                    roleState.roles[index].roleName
                                            .contains('admin')
                                        ? (Icons.admin_panel_settings)
                                        : roleState.roles[index].roleName
                                                .contains('nurse')
                                            ? Icons.local_hospital_outlined
                                            : roleState.roles[index].roleName
                                                    .contains('mom')
                                                ? Icons.pregnant_woman_rounded
                                                : Icons.person_outline,
                                    size: 60.0,
                                  ),
                                  title: Text(
                                    '${roleState.roles[index].roleName}',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  // subtitle: Text('----'),
                                  trailing: Wrap(
                                    spacing: 4.0,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RoleDetails.routeName,
                                              arguments: RoleArgument(
                                                  role: roleState.roles[index],
                                                  edit: false));
                                        },
                                        child: Icon(Icons.description_sharp),
                                      ),
                                      SizedBox(width: 20.0),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            RoleDetails.routeName,
                                            arguments: RoleArgument(
                                                role: roleState.roles[index],
                                                edit: true),
                                          );
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
