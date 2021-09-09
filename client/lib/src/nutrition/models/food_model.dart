class Food {
  final dynamic id;
  final String? name;
  final String? type;
  final String? display;
  final dynamic image;
  final String? description;

  Food(
      {this.id,
      this.name,
      this.type,
      this.display,
      this.image,
      this.description});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json['_id'],
        name: json['name'],
        type: json['type'],
        display: json['display'],
        image: json['image'],
        description: json['description']);
  }
}
