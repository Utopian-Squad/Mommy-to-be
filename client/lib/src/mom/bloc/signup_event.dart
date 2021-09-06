abstract class SignUpEvent {}

class SignUpFirstNameChanged extends SignUpEvent {
  final String firstName;

  SignUpFirstNameChanged({required this.firstName});
}

class SignUpLastNameChanged extends SignUpEvent {
  final String lastName;

  SignUpLastNameChanged({required this.lastName});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  SignUpPhoneNumberChanged({required this.phoneNumber});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpImageChanged extends SignUpEvent {
  final dynamic image;

  SignUpImageChanged({required this.image});
}

class SignUpDateOfBirthChanged extends SignUpEvent {
  final String dateOfBirth;

  SignUpDateOfBirthChanged({required this.dateOfBirth});
}

class SignUpConceivingDateChanged extends SignUpEvent {
  final String conceivingDate;

  SignUpConceivingDateChanged({required this.conceivingDate});
}

class SignUpCvChanged extends SignUpEvent {
  final dynamic cv;

  SignUpCvChanged({required this.cv});
}

class SignUpGenderChanged extends SignUpEvent {
  final String gender;

  SignUpGenderChanged({required this.gender});
}

class Reset extends SignUpEvent {}

class SignUpBloodTypeChanged extends SignUpEvent {
  final String bloodType;

  SignUpBloodTypeChanged({required this.bloodType});
}

class SignUpSubmitted extends SignUpEvent {}
