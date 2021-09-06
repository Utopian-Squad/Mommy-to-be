import 'dart:io';

import 'package:client/src/mom/bloc/bloc.dart';

import 'package:client/src/mom/models/user.dart';
import 'package:client/src/mom/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthenticationBloc authenticationBloc;
  SignUpBloc({required this.authRepo, required this.authenticationBloc})
      : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is SignUpLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is SignUpPhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpDateOfBirthChanged) {
      yield state.copyWith(dateOfBirth: event.dateOfBirth);
    } else if (event is SignUpConceivingDateChanged) {
      yield state.copyWith(conceivingDate: event.conceivingDate);
    } else if (event is SignUpGenderChanged) {
      yield state.copyWith(gender: event.gender);
    } else if (event is SignUpBloodTypeChanged) {
      yield state.copyWith(bloodType: event.bloodType);
    } else if (event is Reset) {
      yield state.copyWith(
          firstName: '',
          lastName: '',
          phoneNumber: '',
          email: '',
          password: '',
          dateOfBirth: '',
          conceivingDate: '',
          image: null,
          cv: null,
          gender: 'Male',
          bloodType: 'A+');
      yield state.copyWith(formStatus: InitialFormStatus());
    } else if (event is SignUpImageChanged) {
      yield state.copyWith(image: event.image);
    } else if (event is SignUpCvChanged) {
      yield state.copyWith(cv: event.cv);
    } else if (event is SignUpSubmitted) {
      User user = User(
        firstName: state.firstName,
        lastName: state.lastName,
        phoneNumber: state.phoneNumber,
        email: state.email,
        password: state.password,
        image: (state.image != null) ? File(state.image?.path) : "",
        cv: (state.cv != null) ? File(state.cv?.files.first.path) : "",
        dateOfBirth: state.dateOfBirth,
        conceivingDate: state.conceivingDate,
        gender: state.gender,
        bloodType: state.bloodType,
      );

      yield state.copyWith(formStatus: FormSubmitting());

      try {
        var userCredential =
            await authRepo.signup(user) as Map<String, dynamic>;
        print(userCredential);
        User newUser = userCredential["user"] as User;

        authenticationBloc.add(LoggedIn(
            phoneNumber: state.phoneNumber,
            role: newUser.role["roleName"],
            token: userCredential["token"],
            id: newUser.id,
            user: newUser));

        yield state.copyWith(formStatus: SubmissionSuccess());
        yield state.copyWith(user: newUser);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed('Something went wrong!'));
        yield state.copyWith(formStatus: SubmissionSuccess());
      }
    }
  }
}
