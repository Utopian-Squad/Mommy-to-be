import 'package:client/src/nutrition/models/food_model.dart';
import 'package:equatable/equatable.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodLoading extends FoodState {}

class FoodOperationSuccess extends FoodState {
  final Iterable<Food> foods;

  FoodOperationSuccess([this.foods = const []]);

  @override
  List<Object> get props => [foods];
}

class FoodOperationFailure extends FoodState {}
