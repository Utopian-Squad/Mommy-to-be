import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState());

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is ClickBottomNavigationEvent) {
      yield state.copyWith(currentIndex: event.currentIndex);
    }
  }
}
