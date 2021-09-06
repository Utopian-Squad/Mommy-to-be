import 'package:client/src/mom/bloc/form_submission_status.dart';
import 'package:client/src/mom/models/user.dart';

class SignUpState {
  final String firstName;
  bool get isFirstNameValid => firstName.length >= 3;
  final String lastName;
  bool get isLastNameValid => lastName.length >= 3;
  final String phoneNumber;
  bool get isPhoneNumberValid => phoneNumber.startsWith('09');
  final String email;
  bool get isEmailValid => email.contains('@');
  final String password;
  bool get isPasswordValid => password.length >= 4;
  final String dateOfBirth;
  bool get isValidDateOfBirth => dateOfBirth.isNotEmpty;
  final String conceivingDate;
  bool get isValidConceivingDate => conceivingDate.isNotEmpty;
  final dynamic image;
  bool get isValidProfile => image != null;
  final String bloodType;
  final dynamic cv;
  bool get isValidCv => cv != null;
  final FormSubmissionStatus formStatus;
  final dynamic role;
  final String gender;
  final User? user;

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.image = null,
    this.dateOfBirth = '',
    this.conceivingDate = "",
    this.bloodType = 'A+',
    this.cv = null,
    this.role = 'mom',
    this.gender = 'male',
    this.user,
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    dynamic image,
    String? dateOfBirth,
    String? conceivingDate,
    String? bloodType,
    dynamic cv,
    String? gender,
    User? user,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        conceivingDate: conceivingDate ?? this.conceivingDate,
        bloodType: bloodType ?? this.bloodType,
        image: image ?? this.image,
        cv: cv ?? this.cv,
        gender: gender ?? this.gender,
        formStatus: formStatus ?? this.formStatus,
        user: user ?? this.user);
  }
}
