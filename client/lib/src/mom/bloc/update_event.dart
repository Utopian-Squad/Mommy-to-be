abstract class UpdateEvent {}

class UpdateFirstNameChanged extends UpdateEvent {
  final String firstName;

  UpdateFirstNameChanged({required this.firstName});
}

class UpdateLastNameChanged extends UpdateEvent {
  final String lastName;

  UpdateLastNameChanged({required this.lastName});
}

class UpdateEmailChanged extends UpdateEvent {
  final String email;

  UpdateEmailChanged({required this.email});
}

class UpdatePhoneNumberChanged extends UpdateEvent {
  final String phoneNumber;

  UpdatePhoneNumberChanged({required this.phoneNumber});
}

class UpdateSubmitted extends UpdateEvent {}

class DeleteAccountClicked extends UpdateEvent {
  final dynamic id;

  DeleteAccountClicked(this.id);
}
