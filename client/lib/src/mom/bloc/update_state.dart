import 'package:client/src/mom/bloc/form_submission_status.dart';

class UpdateState {
  final String firstName;
  bool get isFirstNameValid => firstName.length >= 3;
  final String lastName;
  bool get isLastNameValid => lastName.length >= 3;
  final String phoneNumber;
  bool get isPhoneNumberValid => phoneNumber.startsWith('09');
  final String email;
  bool get isEmailValid => email.contains('@');
  final FormSubmissionStatus formStatus;

  UpdateState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.formStatus = const InitialFormStatus(),
  }) ;

  UpdateState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    FormSubmissionStatus? formStatus
    }){
    return UpdateState(
      firstName: firstName??this.firstName,
      lastName: lastName??this.lastName,
      email: email??this.email,
      phoneNumber: phoneNumber??this.phoneNumber,
      formStatus: formStatus??this.formStatus,
    );
  }

}
