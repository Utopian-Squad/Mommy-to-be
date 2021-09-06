import 'package:client/src/mom/bloc/update_event.dart';
import 'package:client/src/mom/bloc/update_state.dart';
import 'package:client/src/mom/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final AuthRepository authRepository;
  UpdateBloc({required this.authRepository})
      : super(UpdateState(
            firstName: "0", lastName: "0", email: "0", phoneNumber: "0"));

  @override
  Stream<UpdateState> mapEventToState(UpdateEvent event) async* {
    if (event is UpdateFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is UpdateLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is UpdateEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is UpdatePhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is UpdateSubmitted) {
      try {
        await authRepository.updateProfile(
            state.firstName, state.lastName, state.email, state.phoneNumber);
      } catch (e) {
        print(e);
      }
    } else if (event is DeleteAccountClicked) {
      try {
        await authRepository.deleteUser(event.id);
      } catch (e) {
        print(e);
      }
    }
  }
}
