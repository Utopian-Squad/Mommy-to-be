import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/role/bloc/bloc.dart';
import 'package:client/src/role/models/role_args.dart';
import 'package:client/src/role/models/role_model.dart';
import 'package:client/src/role/screens/role_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleDetails extends StatelessWidget {
  final RoleArgument args;
  static const String routeName = "/roleDetail";
  static dynamic roleNameController = TextEditingController();

  RoleDetails({required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state is RoleLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: args.edit == true
                ? Text("Edit Role")
                : args.create == true
                    ? Text("Create Role")
                    : Text("Detail Role"),
            backgroundColor: Colors.pink[400],
          ),
          drawer: NavigationDrawerWidget(),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          spreadRadius: 2)
                    ]),
                child: Column(
                  children: [
                    (args.edit)
                        ? Container(
                            padding: EdgeInsets.only(top: 25.0),
                            height: 40.0,
                            child: Text(
                              'Role ${args.edit ? 'Edit' : 'Details'} of ${args.role?.roleName}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        : (args.create)
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: roleNameController,
                                  style: TextStyle(
                                    height: 1.2,
                                    fontSize: 20,
                                  ),
                                  cursorColor: Color(0xFFD32026),
                                  decoration: InputDecoration(
                                    hintText: "Role Name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                    labelText: "Role",
                                    labelStyle: TextStyle(
                                        color: Colors.redAccent, fontSize: 14),
                                    contentPadding: EdgeInsets.only(left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pink, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pink, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 25.0),
                                height: 40.0,
                                child: Text(
                                  'Role ${args.edit ? 'Edit' : 'Details'} of ${args.role?.roleName}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Privileges",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PreviligeBuilder(
                      args: args,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PreviligeBuilder extends StatefulWidget {
  final RoleArgument args;

  PreviligeBuilder({required this.args});

  @override
  _PreviligeBuilderState createState() => _PreviligeBuilderState();
}

class _PreviligeBuilderState extends State<PreviligeBuilder> {
  Map<String, dynamic> result = {"roleName": '', "privileges": []};
  Map<String, dynamic> mainResult = {"roleName": '', "privileges": []};
  Map<String, dynamic> forCreate = {
    "roleName": '',
    "privileges": [
      {"title": "exercise", "permissions": []},
      {"title": "user", "permissions": []},
      {"title": "food", "permissions": []},
      {"title": "suggestion", "permissions": []},
      {"title": "role", "permissions": []},
    ]
  };

  @override
  Widget build(BuildContext context) {
    mainResult["roleName"] = (widget.args.create)
        ? forCreate["roleName"] = "newRole"
        : widget.args.role?.roleName;

    mainResult["privileges"] = (widget.args.edit)
        ? widget.args.role?.privileges
            .map((privilege) => {
                  "title": privilege["title"],
                  "permissions": privilege["permissions"]
                })
            .toList()
        : (widget.args.create)
            ? forCreate
            : widget.args.role?.privileges
                .map((privilege) => {
                      "title": privilege["title"],
                      "permissions": privilege["permissions"]
                    })
                .toList();

    print(mainResult);
    result = widget.args.edit
        ? {
            "exercise": mainResult["privileges"][0]["permissions"],
            "food": mainResult["privileges"][2]["permissions"],
            "suggestion": mainResult["privileges"][3]["permissions"],
            "role": mainResult["privileges"][4]["permissions"],
            "user": mainResult["privileges"][1]["permissions"]
          }
        : widget.args.create
            ? {
                "exercise": forCreate["privileges"][0]["permissions"],
                "food": forCreate["privileges"][2]["permissions"],
                "suggestion": forCreate["privileges"][3]["permissions"],
                "role": forCreate["privileges"][4]["permissions"],
                "user": forCreate["privileges"][1]["permissions"]
              }
            : {
                "exercise": mainResult["privileges"][0]["permissions"],
                "food": mainResult["privileges"][2]["permissions"],
                "suggestion": mainResult["privileges"][3]["permissions"],
                "role": mainResult["privileges"][4]["permissions"],
                "user": mainResult["privileges"][1]["permissions"]
              };
    dynamic changeResultState = (title, permission) {
      setState(() {
        if (result[title].contains(permission)) {
          result[title].remove(permission);
        } else {
          result[title].add(permission);
        }
      });
    };
    return Column(
      children: [
        checkBoxBuild('Exercise', changeResultState),
        paddedHorizontalLine(),
        checkBoxBuild('Food', changeResultState),
        paddedHorizontalLine(),
        checkBoxBuild('Suggestion', changeResultState),
        paddedHorizontalLine(),
        checkBoxBuild('Role', changeResultState),
        paddedHorizontalLine(),
        checkBoxBuild('User', changeResultState),
        paddedHorizontalLine(),
        (widget.args.edit)
            ? BlocBuilder<RoleBloc, RoleState>(
                builder: (context, roleState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          print("clicked");
                          BlocProvider.of<RoleBloc>(context).add(RoleUpdate(
                              Role(
                                  id: widget.args.role?.id,
                                  roleName: '${widget.args.role?.roleName}',
                                  privileges: mainResult["privileges"])));
                          Navigator.pushNamed(
                            context,
                            RoleManage.routeName,
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text(
                              "Submit role",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : (widget.args.create)
                ? BlocBuilder<RoleBloc, RoleState>(
                    builder: (context, roleState) {
                      // print(RoleDetails.roleNameController.text);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("clicked");
                              BlocProvider.of<RoleBloc>(context).add(RoleCreate(
                                  Role(
                                      roleName:
                                          '${RoleDetails.roleNameController.text}',
                                      privileges: forCreate["privileges"])));
                              Navigator.pushNamed(
                                context,
                                RoleManage.routeName,
                              );
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Text(
                                  "Create role",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container()
      ],
    );
  }

  Widget checkBoxBuild(String title, dynamic handleResultChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '${title}',
          textAlign: TextAlign.start,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: widget.args.edit
                          ? Colors.blueAccent
                          : widget.args.create
                              ? Colors.blueAccent
                              : Colors.grey,
                      value: result[title.replaceAll(' ', '').toLowerCase()]
                          .contains("create"),
                      onChanged: (bool? value) => widget.args.edit
                          ? handleResultChange(
                              title.replaceAll(' ', '').toLowerCase(), "create")
                          : widget.args.create
                              ? handleResultChange(
                                  title.replaceAll(' ', '').toLowerCase(),
                                  "create")
                              : null,
                    ),
                    Text('CREATE')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: widget.args.edit
                            ? Colors.blueAccent
                            : widget.args.create
                                ? Colors.blueAccent
                                : Colors.grey,
                        value: result[title.replaceAll(' ', '').toLowerCase()]
                            .contains("read"),
                        onChanged: (bool? value) => widget.args.edit
                            ? handleResultChange(
                                title.replaceAll(' ', '').toLowerCase(), "read")
                            : widget.args.create
                                ? handleResultChange(
                                    title.replaceAll(' ', '').toLowerCase(),
                                    "read")
                                : null),
                    Text('READ')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: widget.args.edit
                            ? Colors.blueAccent
                            : widget.args.create
                                ? Colors.blueAccent
                                : Colors.grey,
                        value: result[title.replaceAll(' ', '').toLowerCase()]
                            .contains("update"),
                        onChanged: (bool? value) => widget.args.edit
                            ? handleResultChange(
                                title.replaceAll(' ', '').toLowerCase(),
                                "update")
                            : widget.args.create
                                ? handleResultChange(
                                    title.replaceAll(' ', '').toLowerCase(),
                                    "update")
                                : null),
                    Text('UPDATE')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: widget.args.edit
                            ? Colors.blueAccent
                            : widget.args.create
                                ? Colors.blueAccent
                                : Colors.grey,
                        value: result[title.replaceAll(' ', '').toLowerCase()]
                            .contains("delete"),
                        onChanged: (bool? value) => widget.args.edit
                            ? handleResultChange(
                                title.replaceAll(' ', '').toLowerCase(),
                                "delete")
                            : widget.args.create
                                ? handleResultChange(
                                    title.replaceAll(' ', '').toLowerCase(),
                                    "delete")
                                : null),
                    Text('DELETE')
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class paddedHorizontalLine extends StatelessWidget {
  const paddedHorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          height: 1,
          color: Color(0xffd32026),
          indent: 40,
          endIndent: 40,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
