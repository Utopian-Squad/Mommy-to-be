import 'package:equatable/equatable.dart';

abstract class SuggestionEvent extends Equatable {
  const SuggestionEvent();
}

class SuggestionLoad extends SuggestionEvent {
  final dynamic countdown;
  const SuggestionLoad({required this.countdown});

  @override
  List<Object> get props => [];
}
