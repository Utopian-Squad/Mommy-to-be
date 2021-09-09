class Suggestion {
  final dynamic id;
  final dynamic countDown;
  final dynamic foodId;
  final dynamic exerciseId;
  final String symptoms;
  final dynamic timeline;
  final String description;

  Suggestion(
      {this.id,
      this.countDown,
      required this.foodId,
      required this.exerciseId,
      required this.symptoms,
      this.timeline,
      required this.description});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
        id: json['_id'],
        countDown: json['countdown'],
        foodId: json['foodId'],
        exerciseId: json['exerciseId'],
        symptoms: json['symptoms'],
        timeline: json['timeline'],
        description: json['description']);
  }
}
