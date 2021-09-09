import 'package:client/src/mom/bloc/auth_bloc.dart';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:client/src/nutrition/blocs/blocs.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/screens/nurse_food_form.dart';
import 'package:client/src/nutrition/widgets/food_detail.dart';
import 'package:client/src/nutrition/widgets/image_slider_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food_card.dart';

class FoodHomeScreen extends StatelessWidget {
  static const String routeName = "/food";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FoodBloc>(context).add(FoodLoad());
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return (state is AuthenticationAuthenticated)
              ? Scaffold(
                  appBar: (state.user?.role["roleName"] != "mom")
                      ? AppBar(
                          title: Text("Foods"),
                          backgroundColor: Colors.pink[400],
                        )
                      : null,
                  drawer: (state.user?.role["roleName"] != "mom")
                      ? NavigationDrawerWidget()
                      : null,
                  body: BlocBuilder<FoodBloc, FoodState>(
                    builder: (context, state) {
                      if (state is FoodOperationSuccess) {
                        final foods = state.foods;
                        return Column(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // margin: EdgeInsets.only(top: 40),
                                  child: ImageSlideFood(),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.recommend_outlined,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Text(
                                    "Recommended foods",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                width: double.infinity,
                                height: 250,
                                child: foods.length == 1 &&
                                        foods.elementAt(0).type == "type"
                                    ? Center(child: Text("No Foods "))
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: foods.length,
                                        itemBuilder: (_, index) {
                                          return GestureDetector(
                                            child: FoodCard(
                                                food: foods.elementAt(index)),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed(FoodDetail.routeName,
                                                    arguments:
                                                        foods.elementAt(index)),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is FoodOperationFailure) {
                        return Text('Could not do Food operation');
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  floatingActionButton: (state
                          .user?.role["privileges"][2]["permissions"]
                          .contains("create"))
                      ? FloatingActionButton(
                          backgroundColor: Colors.pinkAccent,
                          child: const Icon(Icons.add),
                          onPressed: () => Navigator.of(context).pushNamed(
                            NurseFoodForm.routeName,
                            arguments: FoodArgument(edit: false),
                          ),
                        )
                      : null,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
