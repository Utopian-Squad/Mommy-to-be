class Exercise {
  final dynamic id;
  final String name;
  final String type;
  final String duration;
  final dynamic image;
  final String description;

  Exercise(
      {this.id,
      required this.name,
      required this.type,
      required this.duration,
      required this.image,
      required this.description});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['_id'],
        name: json['name'],
        type: json['type'],
        duration: json['duration'],
        image: json['image'],
        description: json['description']);
  }
}
