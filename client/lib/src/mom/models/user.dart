class User {
  final dynamic id;
  String firstName;
  String lastName;
  String email;
  dynamic phoneNumber;
  String? password;
  dynamic image;
  String dateOfBirth;
  dynamic conceivingDate;
  dynamic address;
  String? bloodType;
  dynamic cv;
  dynamic gender;
  final dynamic role;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.password,
    required this.image,
    required this.dateOfBirth,
    this.conceivingDate,
    this.address,
    this.bloodType,
    this.cv,
    this.role,
    this.gender,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        image,
        dateOfBirth,
        conceivingDate,
        address,
        bloodType,
        cv,
        role,
        gender
      ];

  @override
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      image: json['image'],
      dateOfBirth: json['dateOfBirth'],
      conceivingDate: json['conceivingDate'],
      bloodType: json['bloodType'],
      cv: json['cv'],
      role: json['roles'],
      gender: json['gender'],
    );
  }

  @override
  String toString() =>
      'User\n  {id: $id, firstName: $firstName, lastName:$lastName, phoneNumber: $phoneNumber,email: $email, image: $image,dateOfBirth: $dateOfBirth, bloodType $bloodType, role: $role}';
}
