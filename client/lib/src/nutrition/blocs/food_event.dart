import 'package:client/src/nutrition/models/food_model.dart';
import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();
}

class FoodLoad extends FoodEvent {
  const FoodLoad();

  @override
  List<Object> get props => [];
}

class FoodCreate extends FoodEvent {
  final Food food;

  const FoodCreate(this.food);

  @override
  List<Object> get props => [food];

  @override
  String toString() => 'Food Created {Food: $food}';
}

class FoodUpdate extends FoodEvent {
  final Food food;

  const FoodUpdate(this.food);

  @override
  List<Object> get props => [food];

  @override
  String toString() => 'Food Updated {Food: $food}';
}

class FoodDelete extends FoodEvent {
  final dynamic id;

  const FoodDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Food Deleted {Food Id: $id}';
}

class FoodPhotoUpload extends FoodEvent {
  final dynamic photo;
  @override
  List<Object> get props => [];
  FoodPhotoUpload({required this.photo});
}
