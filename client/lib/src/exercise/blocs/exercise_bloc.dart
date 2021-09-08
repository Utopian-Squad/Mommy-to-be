import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';
import 'package:client/src/exercise/blocs/exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseBloc({required this.exerciseRepository}) : super(ExerciseLoading());

  @override
  Stream<ExerciseState> mapEventToState(ExerciseEvent event) async* {
    if (event is ExerciseLoad) {
      yield ExerciseLoading();

      try {
        final exercises = await exerciseRepository.fetchAll();
        yield ExerciseOperationSuccess(exercises);
      } catch (_) {
        yield ExerciseOperationFailure();
      }
    }

    if (event is ExerciseCreate) {
      try {
        await exerciseRepository.create(event.exercise);

        final exercises = await exerciseRepository.fetchAll();
        yield ExerciseOperationSuccess(exercises);
      } catch (_) {
        yield ExerciseOperationFailure();
      }
    }

    if (event is ExerciseUpdate) {
      try {
        
        await exerciseRepository.update(event.exercise.id, event.exercise);
        final exercises = await exerciseRepository.fetchAll();
        yield ExerciseOperationSuccess(exercises);
      } catch (_) {
        yield ExerciseOperationFailure();
      }
    }

    if (event is ExerciseDelete) {
      try {
        await exerciseRepository.delete(event.id);
        final exercises = await exerciseRepository.fetchAll();
        yield ExerciseOperationSuccess(exercises);
      } catch (_) {
        yield ExerciseOperationFailure();
      }
    }
  }
}
