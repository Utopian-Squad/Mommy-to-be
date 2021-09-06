import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/screens/dashboard.dart';
import 'package:client/src/mom/screens/signup.dart';
import 'package:client/src/utilities/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatefulWidget {
  Signin({Key? key}) : super(key: key);
  static const String routeName = "/signin";

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, stateLogin) async {
            final formStatus = stateLogin.formStatus;
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
          BlocProvider.of<LoginBloc>(context).add(LoginLoggedOut());
          if (token) {
            if (userRole == 'mom') {
              Navigator.of(context).pushNamed(BottomNavigation.routeName);
            } else {
              Navigator.of(context).pushNamed(Dashboard.routeName);
            }
          }
        }),
      ],
      child: BlocProvider(
        create: (context) => ToggleBloc(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'assets/images/top.svg',
                  width: 200,
                  height: 180,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        "Signin",
                        style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginPhoneNumberChanged(
                                      phoneNumber: value)),
                              validator: (value) => state.isPhoneNumberValid
                                  ? null
                                  : 'Invalid Phone Number',
                              decoration: InputDecoration(
                                icon: Icon(Icons.phone, color: Colors.purple),
                                hintText: "Enter Phone number",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<ToggleBloc, VisibilityState>(
                          builder: (context, toggleState) {
                            return BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: toggleState.isVisible,
                                  onChanged: (value) => context
                                      .read<LoginBloc>()
                                      .add(LoginPasswordChanged(
                                          password: value)),
                                  validator: (value) => state.isPasswordValid
                                      ? null
                                      : 'Password must be at least 4 character',
                                  decoration: InputDecoration(
                                    suffixIcon: toggleState.isVisible
                                        ? IconButton(
                                            onPressed: () {
                                              context.read<ToggleBloc>().add(
                                                  ToggleEvent.toggleVisibility);
                                            },
                                            icon: Icon(Icons.visibility_off))
                                        : IconButton(
                                            onPressed: () {
                                              context.read<ToggleBloc>().add(
                                                  ToggleEvent.toggleVisibility);
                                            },
                                            icon: Icon(Icons.visibility)),
                                    icon: Icon(Icons.vpn_key,
                                        color: Colors.purple),
                                    hintText: "Enter Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return state.formStatus is FormSubmitting
                                ? CircularProgressIndicator()
                                : Container(
                                    height: 50,
                                    width: 300,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      color: Colors.pink[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<LoginBloc>()
                                              .add(LoginSubmitted());
                                        } else {
                                          print('Not ok');
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Text(
                        "Not have Account ? ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        Signup.routeName,
                                        arguments: "mom");
                                  },
                                  child: Text(
                                    "Sign up as a Mother",
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(65, 20, 0, 0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        Signup.routeName,
                                        arguments: "nurse");
                                  },
                                  child: Text(
                                    "Sign up as a Nurse",
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
