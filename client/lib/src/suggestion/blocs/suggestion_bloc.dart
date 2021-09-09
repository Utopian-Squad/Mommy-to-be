import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/suggestion/repository/suggestion_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'suggestion_event.dart';
import 'suggestion_state.dart';
import 'package:client/src/suggestion/blocs/suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState> {
  final SuggestionRepository suggestionRepository;

  SuggestionBloc({required this.suggestionRepository})
      : super(SuggestionLoading());

  @override
  Stream<SuggestionState> mapEventToState(SuggestionEvent event) async* {
    if (event is SuggestionLoad) {
      yield SuggestionLoading();

      try {
        final suggestions = await suggestionRepository.fetchAll(event.countdown);
        yield SuggestionOperationSuccess(suggestions);
      } catch (_) {
        yield SuggestionOperationFailure();
      }
    }
  }
}
