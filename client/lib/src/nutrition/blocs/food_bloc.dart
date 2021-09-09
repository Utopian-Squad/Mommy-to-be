import 'package:client/src/nutrition/repository/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc({required this.foodRepository}) : super(FoodLoading());

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FoodLoad) {
      yield FoodLoading();

      try {
        final foods = await foodRepository.fetchAll();
        yield FoodOperationSuccess(foods);
      } catch (_) {
        yield FoodOperationFailure();
      }
    }

    if (event is FoodCreate) {
      try {
        await foodRepository.create(event.food);

        final foods = await foodRepository.fetchAll();
        yield FoodOperationSuccess(foods);
      } catch (_) {
        yield FoodOperationFailure();
      }
    }

    if (event is FoodUpdate) {
      try {
        await foodRepository.update(event.food.id, event.food);

        final foods = await foodRepository.fetchAll();
        yield FoodOperationSuccess(foods);
      } catch (_) {
        yield FoodOperationFailure();
      }
    }

    if (event is FoodDelete) {
      try {
        await foodRepository.delete(event.id);
        final foods = await foodRepository.fetchAll();
        yield FoodOperationSuccess(foods);
      } catch (_) {
        yield FoodOperationFailure();
      }
    }
  }
}
