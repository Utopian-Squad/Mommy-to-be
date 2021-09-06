import 'package:client/src/chat/screens/home_screen.dart';
import 'package:client/src/exercise/models/exercise_argument.dart';
import 'package:client/src/exercise/models/models.dart';
import 'package:client/src/exercise/screens/nurse_exercise_form.dart';
import 'package:client/src/exercise/widgets/exercise_detail.dart';
import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/mom/screens/entry_screen.dart';
import 'package:client/src/mom/screens/signup.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/models/food_model.dart';
import 'package:client/src/nutrition/screens/nurse_food_form.dart';
import 'package:client/src/nutrition/widgets/food_detail.dart';
import 'package:client/src/nutrition/widgets/food_home.dart';
import 'package:client/src/role/models/role_args.dart';
import 'package:client/src/role/screens/role_details.dart';
import 'package:client/src/role/screens/role_manage.dart';
import 'package:client/src/user_list/models/user_args.dart';
import 'package:client/src/user_list/screens/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:client/src/mom/screens/screens.dart';
import 'package:client/src/utilities/navigation_controller.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
    
      case Signup.routeName:
        return MaterialPageRoute(
            builder: (ctx) => Signup(
                  args: settings.arguments.toString(),
                ));
      case Signin.routeName:
        return MaterialPageRoute(builder: (ctx) => Signin());
      case BottomNavigation.routeName:
        return MaterialPageRoute(builder: (ctx) => BottomNavigation());

      case ExerciseDetail.routeName:
        Exercise exercise = settings.arguments as Exercise;
        return MaterialPageRoute(
            builder: (ctx) => ExerciseDetail(exercise: exercise));

      case NurseExerciseForm.routeName:
        ExerciseArgument args = settings.arguments as ExerciseArgument;
        return MaterialPageRoute(
            builder: (ctx) => NurseExerciseForm(args: args));

      case ExerciseHomeScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => ExerciseHomeScreen());

      case NurseFoodForm.routeName:
        FoodArgument args = settings.arguments as FoodArgument;
        return MaterialPageRoute(builder: (ctx) => NurseFoodForm(args: args));

      case FoodDetail.routeName:
        Food food = settings.arguments as Food;
        return MaterialPageRoute(builder: (ctx) => FoodDetail(food: food));

      case FoodHomeScreen.routeName:
        return MaterialPageRoute(builder: (ctx) => FoodHomeScreen());

      case HomePage.routeName:
        return MaterialPageRoute(builder: (ctx) => HomePage());

      case RoleDetails.routeName:
        RoleArgument args = settings.arguments as RoleArgument;
        return MaterialPageRoute(builder: (ctx) => RoleDetails(args: args));
      case RoleManage.routeName:
        return MaterialPageRoute(builder: (ctx) => RoleManage());

      case UserDetails.routeName:
        UserArguments args = settings.arguments as UserArguments;
        return MaterialPageRoute(builder: (ctx) => UserDetails(args: args));

      case Dashboard.routeName:
        return MaterialPageRoute(builder: (ctx) => Dashboard());
      default:
        throw FormatException("Route is not foumd");
    }
  }
}
