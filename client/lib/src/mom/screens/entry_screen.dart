import 'dart:ui';

import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/widgets/entry_card.dart';
import 'package:client/src/mom/widgets/image_slider.dart';
import 'package:client/src/suggestion/blocs/suggestion_bloc.dart';
import 'package:client/src/suggestion/blocs/suggestion_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return (authState is AuthenticationAuthenticated)
            ? Scaffold(
                appBar: (authState.user?.role["roleName"] != "mom")
                    ? AppBar(
                        title: Text("Foods"),
                        backgroundColor: Colors.pink[400],
                      )
                    : null,
                body: BlocBuilder<SuggestionBloc, SuggestionState>(
                  builder: (context, state) {
                    if (state is SuggestionOperationSuccess) {
                      var date = authState.user?.conceivingDate;
                      var date_sp = date.split("/");
                      int year = int.parse(date_sp[0]);
                      int month = int.parse(date_sp[1]);
                      int day = int.parse(date_sp[2]);

                      print(year);

                      final suggestions = state.suggestions;
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 1.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Center(
                                            child: Text(
                                              "Mommy To Be",
                                              style: GoogleFonts.pacifico(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 36,
                                                color: Colors.purple,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 280.0,
                                            width: 390,
                                            child: ImageSlide()),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Center(
                                          child: Text(
                                            "Baby weekly Dimensions",
                                            style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 30,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "${DateFormat('EEE, MMM d, ' 'yyyy').format(DateTime(year, month, day))}",
                                                    style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 22,
                                                      color: Colors.pink,
                                                    ),
                                                  ),
                                                  Text("conceiving date")
                                                ],
                                              ),
                                              SizedBox(
                                                width: 25.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${DateFormat('EEE, MMM d, ' 'yyyy').format(DateTime(year, month, day).add(const Duration(days: 280)))}',
                                                    style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 22,
                                                      color: Colors.pink,
                                                    ),
                                                  ),
                                                  Text("Due date")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                '${DateTime(year, month, day).add(
                                                      const Duration(days: 280),
                                                    ).difference(DateTime.now()).inDays}',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.pink),
                                              ),
                                              Text("Days left for due"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  child: Column(
                                    children: [
                                      ...state.suggestions.map(
                                        (e) => (suggestionCard(
                                          suggestion: e,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Being pregnant is wonderful and miraculous, but it comes with quite a few discomforts, aches and pains, a million unanswered questions—and suddenly all your clothes don’t fit. There are a few essential items you need when you are expecting that will make the experience more healthy and comfortable. But sometimes the long list of pregnancy must-haves can seem a little daunting.",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 350,
                                  child: Image.network(
                                      "https://thumbs.dreamstime.com/b/pregnant-woman-shopping-isolated-white-studio-portrait-beautiful-young-bags-background-44622804.jpg"),
                                ),
                                Text(
                                  "Shopping for the coming angel!",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.pink),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      "“Everything grows rounder and wider and weirder, and I sit here in the middle of it all and wonder who in the world you will turn out to be.” ",
                                      style: TextStyle(fontSize: 16)),
                                ),
                                Image.network(
                                    "https://mch.umn.edu/wp-content/uploads/2012/03/pregnant-women-main.jpg"),
                                Text(
                                  "Always health comes first!",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.pink),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is SuggestionOperationFailure) {
                      return Text('Could not do Suggestion operation');
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
