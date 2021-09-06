import 'dart:ui';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/bloc/update_bloc.dart';
import 'package:client/src/mom/bloc/update_event.dart';
import 'package:client/src/mom/bloc/update_state.dart';
import 'package:client/src/mom/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  late final String? args;
  final formKey = GlobalKey<FormState>();
  static const String routeName = "/";

  showAlertDialog(BuildContext context, dynamic id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () {
        Navigator.pop(context);
        BlocProvider.of<UpdateBloc>(context).add(DeleteAccountClicked(id));
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        Navigator.of(context).popAndPushNamed(Signin.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Account"),
      content: Text("Would you like to delete your account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.args);
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.errorMessage.toString());
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
          final userRole =
              await context.read<AuthenticationBloc>().userRepository.getRole();
          final token = await context
              .read<AuthenticationBloc>()
              .userRepository
              .hasToken();
          if (token) {
            if (userRole == 'mom') {
              BlocProvider.of<SignUpBloc>(context).add(Reset());
            }
            if (userRole == 'nurse') {
              BlocProvider.of<SignUpBloc>(context).add(Reset());
            }
            if (userRole == 'admin') {
              BlocProvider.of<SignUpBloc>(context).add(Reset());
            }
          }
        })
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          return (authState is AuthenticationAuthenticated)
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.pink[400],
                    title: Text("Edit Profile"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showAlertDialog(context, authState.user?.id);
                        },
                        icon: Icon(Icons.delete),
                      )
                    ],
                  ),
                  body: Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: BlocBuilder<UpdateBloc, UpdateState>(
                          builder: (context, updateState) {
                            return BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, authState) {
                                return (authState
                                        is AuthenticationAuthenticated)
                                    ? ListView(
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            "Profile",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          imageProfile(),
                                          SizedBox(
                                            height: 35,
                                          ),

                                          // buildTextField("First Name",
                                          //     "${authState.user?.firstName}", false, false),
                                          // buildTextField("last Name",
                                          //     "${authState.user?.lastName}", false, false),
                                          // buildTextField("email",
                                          //     "${authState.user?.email}", false, false),
                                          // buildTextField(
                                          //     "Phone Number",
                                          //     "${authState.user?.phoneNumber}",
                                          //     false,
                                          //     false),
                                          // buildTextField(
                                          //     "DOB",
                                          //     "${authState.user?.dateOfBirth}",
                                          //     false,
                                          //     true),

                                          BlocBuilder<UpdateBloc, UpdateState>(
                                            builder: (context, state) {
                                              return TextInput(
                                                prefixIcon: Icons.group,
                                                labelText:
                                                    '${authState.user?.firstName}',
                                                hintText:
                                                    '${authState.user?.firstName}',
                                                keyboardType:
                                                    TextInputType.text,
                                                onChanged: (value) => context
                                                    .read<UpdateBloc>()
                                                    .add(UpdateFirstNameChanged(
                                                        firstName: value)),
                                                onValidate: (value) =>
                                                    state.isFirstNameValid
                                                        ? null
                                                        : 'First name required',
                                              );
                                            },
                                          ),

                                          BlocBuilder<UpdateBloc, UpdateState>(
                                            builder: (context, state) {
                                              return TextInput(
                                                prefixIcon: Icons.group,
                                                labelText:
                                                    '${authState.user?.lastName}',
                                                hintText:
                                                    '${authState.user?.lastName}',
                                                keyboardType:
                                                    TextInputType.text,
                                                onChanged: (value) => context
                                                    .read<UpdateBloc>()
                                                    .add(UpdateLastNameChanged(
                                                        lastName: value)),
                                                onValidate: (value) => state
                                                        .isLastNameValid
                                                    ? null
                                                    : 'LastName name required',
                                              );
                                            },
                                          ),

                                          BlocBuilder<UpdateBloc, UpdateState>(
                                            builder: (context, state) {
                                              return TextInput(
                                                prefixIcon: Icons.group,
                                                labelText:
                                                    '${authState.user?.email}',
                                                hintText:
                                                    '${authState.user?.email}',
                                                keyboardType:
                                                    TextInputType.text,
                                                onChanged: (value) => context
                                                    .read<UpdateBloc>()
                                                    .add(UpdateEmailChanged(
                                                        email: value)),
                                                onValidate: (value) => state
                                                        .isEmailValid
                                                    ? null
                                                    : "Email doesn't contain @",
                                              );
                                            },
                                          ),

                                          BlocBuilder<UpdateBloc, UpdateState>(
                                            builder: (context, state) {
                                              return TextInput(
                                                prefixIcon: Icons.group,
                                                labelText:
                                                    '${authState.user?.phoneNumber}',
                                                hintText:
                                                    '${authState.user?.phoneNumber}',
                                                keyboardType:
                                                    TextInputType.phone,
                                                onChanged: (value) => context
                                                    .read<UpdateBloc>()
                                                    .add(
                                                        UpdatePhoneNumberChanged(
                                                            phoneNumber:
                                                                value)),
                                                onValidate: (value) => state
                                                        .isFirstNameValid
                                                    ? null
                                                    : 'Phone number starts with 09',
                                              );
                                            },
                                          ),

                                          authState.user?.role["roleName"] ==
                                                  "mom"
                                              ? Container()
                                              // buildTextField(
                                              //     "Conceiving Date",
                                              //     "${authState.user?.conceivingDate}",
                                              //     false,
                                              //     true)
                                              : Divider(),
                                          // buildTextField("Blood Type",
                                          //     "${authState.user?.bloodType}", false, true),
                                          authState.user?.role["roleName"] ==
                                                      "nurse" ||
                                                  authState.user
                                                          ?.role["roleName"] ==
                                                      "admin"
                                              ? Container()
                                              // buildTextField("Gender",
                                              //     "${authState.user?.gender}", false, true)
                                              : Divider(),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // ignore: deprecated_member_use
                                              OutlineButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                //===================Cancel Button================
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              AuthenticationBloc>(
                                                          context)
                                                      .add(LoggedOut());
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(LoginLoggedOut());
                                                  Navigator.of(context)
                                                      .popAndPushNamed(
                                                          Signin.routeName);
                                                },
                                                child: Text("LOGOUT",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        letterSpacing: 2.2,
                                                        color: Colors.black)),
                                              ),
                                              // ignore: deprecated_member_use
                                              BlocBuilder<UpdateBloc,
                                                  UpdateState>(
                                                builder: (context, state) {
                                                  return (state.formStatus
                                                          is FormSubmitting)
                                                      ? CircularProgressIndicator()
                                                      : RoundButton(
                                                          text:
                                                              'Update Profile',
                                                          width: 60,
                                                          textColor:
                                                              Color(0xffd32026),
                                                          onPressed: () {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              BlocProvider.of<
                                                                          UpdateBloc>(
                                                                      context)
                                                                  .add(
                                                                      UpdateSubmitted());
                                                              BlocProvider.of<
                                                                          UpdateBloc>(
                                                                      context)
                                                                  .add(UpdateFirstNameChanged(
                                                                      firstName:
                                                                          ''));
                                                              BlocProvider.of<
                                                                          UpdateBloc>(
                                                                      context)
                                                                  .add(UpdateLastNameChanged(
                                                                      lastName:
                                                                          ''));
                                                              BlocProvider.of<
                                                                          UpdateBloc>(
                                                                      context)
                                                                  .add(UpdateEmailChanged(
                                                                      email:
                                                                          ''));
                                                              BlocProvider.of<
                                                                          UpdateBloc>(
                                                                      context)
                                                                  .add(UpdatePhoneNumberChanged(
                                                                      phoneNumber:
                                                                          ''));

                                                              // BlocProvider.of<AuthenticationBloc>(context)
                                                              //     .add(LoggedOut());

                                                              // Navigator.of(context)
                                                              //     .popAndPushNamed(
                                                              //         RouteGenerator
                                                              //             .welcomeScreen);
                                                            }
                                                            // BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
                                                          },
                                                        );
                                                },
                                              ),

                                              // RaisedButton(
                                              //   //=============================Save button===============

                                              //   color: Colors.purpleAccent,
                                              //   padding:
                                              //       EdgeInsets.symmetric(horizontal: 50),
                                              //   elevation: 2,
                                              //   shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(20)),
                                              //   onPressed: () {
                                              //     BlocProvider.of<UpdateBloc>(context)
                                              //         .add(UpdateSubmitted());
                                              //   },
                                              //   child: Text(
                                              //     "SAVE",
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         letterSpacing: 2.2,
                                              //         color: Colors.white),
                                              //   ),
                                              // )
                                            ],
                                          )
                                        ],
                                      )
                                    : Container();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        },
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 58,
            backgroundImage: AssetImage("assets/images/mom_.png"),
            // child: Stack(
            //   children: [
            //     Align(
            //       alignment: Alignment.bottomRight,
            //       child: CircleAvatar(
            //         radius: 18,
            //         backgroundColor: Colors.white70,
            //         child: Icon(CupertinoIcons.camera),
            //       ),
            //     ),
            //   ],
            // ),
          )
        ],
      ),
    );
  }

  // Widget buildTextField(String labelText, String placeholder,
  //     bool isPasswordTextField, bool readOnly, UpdateEvent updateEvent) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 35.0),
  //     child: TextField(
  //       onChanged: (state) => context.read<UpdateBloc>().add(updateEvent),
  //       readOnly: readOnly,
  //       obscureText: isPasswordTextField ? showPassword : false,
  //       decoration: InputDecoration(
  //           suffixIcon: isPasswordTextField
  //               ? IconButton(
  //                   //password holder==================
  //                   onPressed: () {
  //                     setState(() {
  //                       showPassword = !showPassword;
  //                     });
  //                   },
  //                   icon: Icon(
  //                     Icons.remove_red_eye,
  //                     color: Colors.grey,
  //                   ),
  //                 )
  //               : null,
  //           contentPadding: EdgeInsets.only(bottom: 3),
  //           labelText: labelText,
  //           floatingLabelBehavior: FloatingLabelBehavior.always,
  //           hintText: placeholder,
  //           hintStyle: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black,
  //           )),
  //     ),
  //   );
  // }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class TextInput extends StatelessWidget {
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obsecureText;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? Function(String?)? onValidate;

  TextInput(
      {this.maxLines,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.hintText,
      this.keyboardType,
      this.obsecureText,
      this.onChanged,
      this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 0.8,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: '$labelText',
          hintText: '$hintText',
          hintStyle: TextStyle(
            color: Color(0xFF707070),
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.blueAccent),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              borderRadius: BorderRadius.circular(30.0)),
        ),
        cursorColor: Colors.blueAccent,
        onChanged: onChanged,
        validator: onValidate,
        keyboardType: keyboardType,
        obscureText: obsecureText ?? false,
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? padding;
  final double? borderCurve;
  final double? width;
  final double? height;

  RoundButton(
      {this.color,
      this.text,
      this.textColor,
      this.onPressed,
      this.padding,
      this.borderCurve,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 12.0),
      child: Material(
        shadowColor: Color(0xffd32026),
        elevation: 10.0,
        color: color,
        borderRadius: BorderRadius.circular(borderCurve ?? 50.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: width ?? 200.0,
          height: height ?? 55.0,
          child: Text(
            '$text',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
