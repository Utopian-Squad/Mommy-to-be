import 'package:client/src/suggestion/data_providers/suggestion_data_provider.dart';
import 'package:client/src/suggestion/models/suggestion_model.dart';

class SuggestionRepository {
  final SuggestionDataProvider dataProvider;
  SuggestionRepository(this.dataProvider);

  Future<List<Suggestion>> fetchAll(int countdown) async {
    return this.dataProvider.fetchAll(countdown);
  }
}
