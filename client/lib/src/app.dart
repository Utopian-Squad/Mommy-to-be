import 'package:client/src/exercise/blocs/blocs.dart';
import 'package:client/src/exercise/data_providers/exercise_data_provider.dart';
import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/exercise/widgets/exercise_detail.dart';
import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/mom/data_providers/auth_data_provider.dart';
import 'package:client/src/mom/repository/auth_repository.dart';
import 'package:client/src/mom/repository/secure_storage.dart';
import 'package:client/src/mom/screens/dashboard.dart';
import 'package:client/src/mom/screens/entry_screen.dart';
import 'package:client/src/mom/screens/signin.dart';
import 'package:client/src/nutrition/data_providers/food_data_provider.dart';
import 'package:client/src/nutrition/repository/food_repository.dart';
import 'package:client/src/role/bloc/bloc.dart';
import 'package:client/src/role/data_provider/role_data_provider.dart';
import 'package:client/src/role/repository/role_repository.dart';
import 'package:client/src/role/screens/role_details.dart';
import 'package:client/src/role/screens/role_manage.dart';
import 'package:client/src/suggestion/blocs/blocs.dart';
import 'package:client/src/suggestion/data_providers/suggestion_data_provider.dart';
import 'package:client/src/suggestion/repository/suggestion_repository.dart';
import 'package:client/src/user_list/bloc/bloc.dart';
import 'package:client/src/user_list/data_provider/user_list_provider.dart';
import 'package:client/src/user_list/repository/user_list_repository.dart';
import 'package:client/src/utilities/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:client/src/utilities/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'mom/bloc/bloc.dart';
import 'mom/bloc/update_bloc.dart';
import 'mom/screens/signup.dart';
import 'nutrition/blocs/blocs.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ExerciseDataProvider().fetchAll();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => FoodBloc(
            foodRepository: FoodRepository(
              FoodDataProvider(),
            ),
          )..add(FoodLoad()),
        ),
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: SecureStorage())),
        BlocProvider(
            create: (context) => SignUpBloc(
                authRepo: AuthRepository(authProvider: AuthProvider()),
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context))),
        BlocProvider(
          create: (context) => LoginBloc(
              authRepository: AuthRepository(authProvider: AuthProvider()),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider(
          create: (context) => RoleBloc(
            roleRepository: RoleRepository(dataProvider: RoleDataProvider()),
          ),
        ),
        BlocProvider(
          create: (context) => ExerciseBloc(
            exerciseRepository: ExerciseRepository(
              ExerciseDataProvider(),
            ),
          )..add(ExerciseLoad()),
        ),
        BlocProvider(
          create: (context) => SuggestionBloc(
            suggestionRepository: SuggestionRepository(
              SuggestionDataProvider(),
            ),
          )..add(SuggestionLoad(countdown: 7)),
        ),
        BlocProvider(
          create: (context) => UserListBloc(
            userListRepository: UserListRepository(
              userListProvider: UserListProvider(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateBloc(
              authRepository: AuthRepository(authProvider: AuthProvider())),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Signin.routeName,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
