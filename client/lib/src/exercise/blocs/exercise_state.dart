import 'package:client/src/exercise/models/exercise_model.dart';
import 'package:equatable/equatable.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseLoading extends ExerciseState {}

class ExerciseOperationSuccess extends ExerciseState {
  final Iterable<Exercise> exercises;

  ExerciseOperationSuccess([this.exercises = const []]);

  @override
  List<Object> get props => [exercises];
}

class ExerciseOperationFailure extends ExerciseState {}
