import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/mom/bloc/auth_bloc.dart';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/nutrition/blocs/blocs.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/models/food_model.dart';
import 'package:client/src/nutrition/screens/nurse_food_form.dart';
import 'package:client/src/nutrition/widgets/food_home.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetail extends StatelessWidget {
  static const String routeName = "/foodDetail";
  final Food food;
  FoodDetail({required this.food});

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
        BlocProvider.of<FoodBloc>(context).add(FoodDelete(id));
        Navigator.of(context).pushNamed(FoodHomeScreen.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Food Deletion"),
      content: Text("Would you like to delete this food?"),
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
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return (state is AuthenticationAuthenticated)
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.pink[400],
                    title: Text("Food Detail"),
                    actions: [
                      (state.user?.role["privileges"][2]["permissions"]
                              .contains("update"))
                          ? IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  NurseFoodForm.routeName,
                                  arguments:
                                      FoodArgument(edit: true, food: this.food),
                                );
                              },
                              icon: Icon(Icons.edit),
                            )
                          : Text(""),
                      (state.user?.role["privileges"][2]["permissions"]
                              .contains("delete"))
                          ? IconButton(
                              onPressed: () {
                                showAlertDialog(context, this.food.id);
                              },
                              icon: Icon(Icons.delete),
                            )
                          : Text("")
                    ],
                  ),
                  body: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.purple[50]),
                    child: Column(
                      children: [
                        Expanded(
                            child: Image.network(
                                "${Constants.imageBaseUrl}images/food/${food.image}")),
                        Text(
                          "${food.name}",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.purple[100],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(80),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("${food.description}"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
