import 'package:client/src/utilities/routes.dart';
import 'package:fancy_bar/fancy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom_navigation_bloc.dart';
import 'bloc/bottom_navigation_event.dart';
import 'bloc/bottom_navigation_state.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          child: FancyBottomBar(
            selectedIndex: state.currentIndex,
            items: [
              FancyItem(
                textColor: Colors.orange,
                title: 'Home',
                icon: Icon(Icons.home),
              ),
              FancyItem(
                textColor: Colors.red,
                title: 'Exercise',
                icon: Icon(Icons.fitness_center),
              ),
              FancyItem(
                textColor: Colors.green,
                title: 'Nutrition',
                icon: Icon(Icons.fastfood),
              ),
              FancyItem(
                textColor: Colors.purple,
                title: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
            onItemSelected: (int index) {
              context.read<BottomNavigationBloc>().add(
                    ClickBottomNavigationEvent(currentIndex: index),
                  );
              print(index);
            },
          ),
        );
      },
    );
  }
}
