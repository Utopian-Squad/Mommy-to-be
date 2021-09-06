import 'dart:io';
import 'package:client/src/mom/screens/dashboard.dart';
import 'package:client/src/utilities/navigation_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/screens/signin.dart';
import 'package:client/src/mom/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  final String? args;

  static const String routeName = "/";

  const Signup({Key? key, this.args}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    BlocProvider.of<SignUpBloc>(context).add(Reset());
    super.initState();
  }

  User user = new User(
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      image: '',
      dateOfBirth: '',
      bloodType: '',
      phoneNumber: '');
//-------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();
  var imagePicker;

  @override
  Widget build(BuildContext context) {
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
            print(userRole);
            if (userRole == 'mom') {
              BlocProvider.of<SignUpBloc>(context).add(Reset());
              Navigator.of(context).pushNamed(BottomNavigation.routeName);
            } else {
              BlocProvider.of<SignUpBloc>(context).add(Reset());
              Navigator.of(context).pushNamed(Dashboard.routeName);
            }
          }
        })
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'assets/images/top.svg',
                  width: 300,
                  height: 190,
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
                        "Signup as ${widget.args}",
                        style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.purple,
                        ),
                      ),
                      //=======================firstName===========================//
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return TextFormField(
                              // controller:
                              //     TextEditingController(text: user.firstName),
                              onChanged: (value) => context
                                  .read<SignUpBloc>()
                                  .add(
                                      SignUpFirstNameChanged(firstName: value)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter something';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.purple,
                                  ),
                                  hintText: 'Enter firstName',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            );
                          },
                        ),
                      ),
                      //=================================lastName=================================
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (value) => context
                                  .read<SignUpBloc>()
                                  .add(SignUpLastNameChanged(lastName: value)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter something';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.purple,
                                  ),
                                  hintText: 'Enter lastName',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            );
                          },
                        ),
                      ),
                      //=============================email===============================

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (value) => context
                                  .read<SignUpBloc>()
                                  .add(SignUpEmailChanged(email: value)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter  Something';
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Enter valid Email';
                                }
                              },
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.purple,
                                ),
                                hintText: "Enter Email",
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

                      ///....................................................phone.................................
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return TextFormField(
                              onChanged: (value) => context
                                  .read<SignUpBloc>()
                                  .add(SignUpPhoneNumberChanged(
                                      phoneNumber: value)),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.purple,
                                ),
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
//////........................................password..................................
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return TextFormField(
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<SignUpBloc>()
                                  .add(SignUpPasswordChanged(password: value)),
                              validator: (value) => state.isPasswordValid
                                  ? null
                                  : 'Password must be at least 4 characters',
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.purple,
                                ),
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
                        ),
                      ),
//...............................................date......................................
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return GestureDetector(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.purple,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 340,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.purple),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Center(
                                            child: Text(state.dateOfBirth == ''
                                                ? "Date of Birth"
                                                : state.dateOfBirth)),
                                      ),
                                    ],
                                  ),
                                  // DatePickerWidget("birth",onClick: ),
                                ],
                              ),
                              onTap: () async {
                                var date = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime(DateTime.now().year - 19),
                                  firstDate: DateTime(DateTime.now().year - 30),
                                  lastDate: DateTime(DateTime.now().year - 18),
                                );
                                // print(date);
                                context.read<SignUpBloc>().add(
                                    SignUpDateOfBirthChanged(
                                        dateOfBirth:
                                            date.toString().split(' ')[0]));
                              },
                            );
                          },
                        ),
                      ),

                      //======================Conceiving Date==========================//

                      widget.args == "mom"
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: BlocBuilder<SignUpBloc, SignUpState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.pregnant_woman,
                                              color: Colors.purple,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 340,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.purple),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Center(
                                                  child: Text(
                                                      state.conceivingDate == ''
                                                          ? "Conceving Date"
                                                          : state
                                                              .conceivingDate)),
                                            ),
                                          ],
                                        ),
                                        // DatePickerWidget("birth",onClick: ),
                                      ],
                                    ),
                                    onTap: () async {
                                      var date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                            DateTime(DateTime.now().year - 1),
                                        lastDate:
                                            DateTime(DateTime.now().year + 1),
                                      );
                                      // print(date);
                                      context.read<SignUpBloc>().add(
                                          SignUpConceivingDateChanged(
                                              conceivingDate: date
                                                  .toString()
                                                  .split(' ')[0]));
                                    },
                                  );
                                },
                              ),
                            )
                          : Divider(),

                      //gender
                      widget.args == "nurse" ? GenderRadio() : Divider(),
                      //Bloodtype
                      BloodTypeRadio(),

                      //image
                      widget.args == "nurse"
                          ? Row(children: [
                              Expanded(
                                child: ImageWidget(), // cv
                              ),
                              Expanded(
                                child: CvWidget(),
                              )
                            ])
                          : Row(children: [
                              Expanded(
                                child: ImageWidget(), // cv
                              ),
                            ]),

                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
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
                                              .read<SignUpBloc>()
                                              .add(SignUpSubmitted());
                                          print('Ok');
                                        } else {
                                          print('Not ok');
                                        }
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(65, 20, 20, 20),
                          child: Row(
                            children: [
                              Text(
                                "Already have Account ? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => Signin()));
                                },
                                child: Text(
                                  "Signin",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class GenderRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.pregnant_woman,
                color: Colors.purple,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 340,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(width: 20,),
                    Text("Gender"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Colors.purple,
                              groupValue: state.gender,
                              onChanged: (value) {
                                print(value);
                                context.read<SignUpBloc>().add(
                                    SignUpGenderChanged(
                                        gender: value.toString()));
                              },
                              value: "Male",
                            ),
                            Text("Male")
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Colors.purple,
                              groupValue: state.gender,
                              onChanged: (value) {
                                print(value);
                                context.read<SignUpBloc>().add(
                                    SignUpGenderChanged(
                                        gender: value.toString()));
                              },
                              value: "Female",
                            ),
                            Text("Female")
                          ],
                        ),
                      ],
                    ),
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

class BloodTypeRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: 350,
            // height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.purple),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(width: 20,),
                Text("Blood Type"),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "A+",
                        ),
                        Text("A+")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "B+",
                        ),
                        Text("B+")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "AB+",
                        ),
                        Text("AB+")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "O+",
                        ),
                        Text("O+")
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "A-",
                        ),
                        Text("A-")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "B-",
                        ),
                        Text("B-")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "AB-",
                        ),
                        Text("AB-")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: Colors.purple,
                          groupValue: state.bloodType,
                          onChanged: (value) => context.read<SignUpBloc>().add(
                              SignUpBloodTypeChanged(
                                  bloodType: value.toString())),
                          value: "O-",
                        ),
                        Text("O-")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageWidget extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () async {
                  var imagePicker =
                      await _picker.pickImage(source: ImageSource.gallery);
                  context
                      .read<SignUpBloc>()
                      .add(SignUpImageChanged(image: imagePicker));
                  // await _picker.pickImage(source: ImageSource.gallery)
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return state.image == null
                        ? CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.purple,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage("assets/images/mom_.png"),
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(File(state.image.path)),
                          );
                  },
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(offset: Offset(1, 1))],
                  ),
                  child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () async {
                          print('aaa');
                          var imagePicker = await _picker.pickImage(
                              source: ImageSource.gallery);
                          context
                              .read<SignUpBloc>()
                              .add(SignUpImageChanged(image: imagePicker));

                          // if (imagePicker != null) {
                          //   final authBloc = BlocProvider.of<AuthBloc>(context);

                          //   authBloc.add(SignupEvent(profile: imagePicker));
                          // }
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        ),
                        iconSize: 15,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
            child: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
          ),
        )),
      ],
    );
  }
}

class CvWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () async {
                  FilePickerResult? cvPicker =
                      await FilePicker.platform.pickFiles();
                  context.read<SignUpBloc>().add(SignUpCvChanged(cv: cvPicker));
                  // await _picker.pickImage(source: ImageSource.gallery)
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return state.cv == null
                        ? Container(
                            child: Center(
                              child: Text("Please upload your CV"),
                            ),
                          )
                        : Container(
                            child: Center(
                              child: Text("CV uploaded"),
                            ),
                          );
                  },
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(offset: Offset(1, 1))],
                  ),
                  child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () async {
                          print('aaa');
                          FilePickerResult? cvPicker =
                              await FilePicker.platform.pickFiles();
                          context
                              .read<SignUpBloc>()
                              .add(SignUpCvChanged(cv: cvPicker));

                          // if (imagePicker != null) {
                          //   final authBloc = BlocProvider.of<AuthBloc>(context);

                          //   authBloc.add(SignupEvent(profile: imagePicker));
                          // }
                        },
                        icon: Icon(
                          Icons.file_copy,
                          color: Colors.grey,
                        ),
                        iconSize: 15,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
            child: Text(
          "CV",
          style: TextStyle(
            fontSize: 22,
          ),
        )),
      ],
    );
  }
}
