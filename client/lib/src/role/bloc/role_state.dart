import 'package:equatable/equatable.dart';

import '../role_management.dart';

class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RolesLoadSuccess extends RoleState {
  final List<dynamic> roles;

  RolesLoadSuccess([this.roles = const []]);

  @override
  List<Object> get props => [roles];
}

class RoleOperationFailure extends RoleState {}

class RadioButtonState extends RoleState {
  final Role role;

  RadioButtonState(this.role);
}

class SubmissionButtonPressedState extends RoleState {}
