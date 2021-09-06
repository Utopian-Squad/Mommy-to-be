import 'package:client/src/exercise/models/exercise_argument.dart';
import 'package:client/src/exercise/screens/nurse_exercise_form.dart';
import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/screens/dashboard.dart';
import 'package:client/src/mom/screens/profile.dart';
import 'package:client/src/mom/screens/signin.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/screens/nurse_food_form.dart';
import 'package:client/src/nutrition/widgets/food_home.dart';
import 'package:client/src/role/screens/role_manage.dart';
import 'package:client/src/user_list/screens/users_screen.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final Padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState is AuthenticationAuthenticated) {
          return Drawer(
            child: Material(
              color: Colors.pink[400],
              child: ListView(
                padding: Padding,
                children: [
                  buildHeader(
                      image:
                          "${Constants.imageBaseUrl}images/user/${authState.user?.image}",
                      name: "${authState.user?.firstName}",
                      phoneNumber: "${authState.user?.phoneNumber}",
                      onClicked: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            ),
                          }),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.desktop_mac,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Food List',
                    icon: Icons.food_bank_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Exercise List',
                    icon: Icons.run_circle_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  if (authState.user?.role["privileges"][2]["permissions"]
                      .contains("create"))
                    buildMenuItem(
                      text: 'Create Food',
                      icon: Icons.food_bank_outlined,
                      onClicked: () => selectedItem(context, 3),
                    ),
                  if (authState.user?.role["privileges"][0]["permissions"]
                      .contains("create"))
                    buildMenuItem(
                        text: 'Create Exercise',
                        icon: Icons.run_circle_outlined,
                        onClicked: () => selectedItem(context, 4)),
                  if (authState.user?.role["roleName"] == "admin")
                    buildMenuItem(
                        text: 'Role Management',
                        icon: Icons.people,
                        onClicked: () => selectedItem(context, 5)),
                  if (authState.user?.role["roleName"] == "admin")
                    buildMenuItem(
                        text: 'User Role Management',
                        icon: Icons.supervised_user_circle_outlined,
                        onClicked: () => selectedItem(context, 7)),
                  if (authState.user?.role["roleName"] == "admin")
                    Divider(
                      color: Colors.white70,
                      height: 4,
                    ),
                  if (authState.user?.role["roleName"] == "admin")
                    SizedBox(height: 24),
                  buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout,
                      onClicked: () {
                        print('Logout Clicked From Dashboard Screen');
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginLoggedOut());
                        Navigator.of(context).popAndPushNamed(Signin.routeName);
                      }),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String phoneNumber,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 31,
                  // backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(image))),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FoodHomeScreen()));
        break;
      case 2:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ExerciseHomeScreen()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                NurseFoodForm(args: FoodArgument(edit: false))));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                NurseExerciseForm(args: ExerciseArgument(edit: false))));
        break;
      case 5:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RoleManage()));
        break;
      case 7:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => UsersListScreen()));
        break;
    }
  }
}
