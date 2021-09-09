import 'package:client/src/suggestion/models/suggestion_model.dart';
import 'package:equatable/equatable.dart';

abstract class SuggestionState extends Equatable {
  const SuggestionState();

  @override
  List<Object> get props => [];
}

class SuggestionLoading extends SuggestionState {}

class SuggestionOperationSuccess extends SuggestionState {
  final List<Suggestion> suggestions;

  SuggestionOperationSuccess([this.suggestions = const []]);

  @override
  List<Object> get props => [suggestions];
}

class SuggestionOperationFailure extends SuggestionState {}
