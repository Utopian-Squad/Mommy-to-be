import 'package:client/src/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:client/src/bottom_navigation/bloc/bottom_navigation_state.dart';
import 'package:client/src/bottom_navigation/bottom_navigation.dart';
import 'package:client/src/exercise/data_providers/exercise_data_provider.dart';
import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/mom/bloc/auth_bloc.dart';
import 'package:client/src/mom/bloc/auth_state.dart';
import 'package:client/src/mom/screens/entry_screen.dart';
import 'package:client/src/mom/screens/profile.dart';
import 'package:client/src/mom/screens/signup.dart';
import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/nutrition/blocs/blocs.dart';
import 'package:client/src/nutrition/data_providers/food_data_provider.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/repository/food_repository.dart';
import 'package:client/src/nutrition/screens/nurse_food_form.dart';
import 'package:client/src/nutrition/widgets/food_home.dart';
import 'package:client/src/role/models/role_model.dart';
import 'package:client/src/suggestion/blocs/blocs.dart';
import 'package:client/src/suggestion/data_providers/suggestion_data_provider.dart';
import 'package:client/src/suggestion/repository/suggestion_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigation extends StatelessWidget {
  // static const String routeName = "/exercise";
  static const String routeName = "/homeScreen";

  final ExerciseRepository exerciseRepository =
      ExerciseRepository(ExerciseDataProvider());
  final FoodRepository foodRepository = FoodRepository(FoodDataProvider());
  final SuggestionRepository suggestionRepository =
      SuggestionRepository(SuggestionDataProvider());

  @override
  Widget build(BuildContext context) {
    final bottom_tabs = [
      // Signup(),
      HomePage(),
      ExerciseHomeScreen(),
      FoodHomeScreen(),
      //NurseExerciseForm(args: ExerciseArgument(edit: false)),
      //NurseFoodForm(args: FoodArgument(edit: false)),

      EditProfilePage()
    ];
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return (authState is AuthenticationAuthenticated)
            ? BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) =>
                        // ExerciseBloc(exerciseRepository: this.exerciseRepository)
                        //   ..add(ExerciseLoad()),
                        SuggestionBloc(
                            suggestionRepository: this.suggestionRepository)
                          ..add(SuggestionLoad(countdown: 7)),
                    child: Scaffold(
                        // appBar: AppBar(),
                        body: bottom_tabs[state.currentIndex],
                        bottomNavigationBar: BottomNav()),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
