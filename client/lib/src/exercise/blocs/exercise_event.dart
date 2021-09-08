import 'package:client/src/exercise/models/exercise_model.dart';
import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();
}

class ExerciseLoad extends ExerciseEvent {
  const ExerciseLoad();

  @override
  List<Object> get props => [];
}

class ExerciseCreate extends ExerciseEvent {
  final Exercise exercise;

  const ExerciseCreate(this.exercise);

  @override
  List<Object> get props => [exercise];

  @override
  String toString() => 'Exercise Created {Exercise: $Exercise}';
}

class ExerciseUpdate extends ExerciseEvent {
  final Exercise exercise;

  const ExerciseUpdate(this.exercise);

  @override
  List<Object> get props => [exercise];

  @override
  String toString() => 'Exercise Updated {Exercise: $exercise}';
}

class ExerciseDelete extends ExerciseEvent {
  final dynamic id;

  const ExerciseDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Exercise Deleted {Exercise Id: $id}';
}

class ExercisePhotoUpload extends ExerciseEvent {
  final dynamic photo;
  @override
  List<Object> get props => [];
  ExercisePhotoUpload({required this.photo});
}
