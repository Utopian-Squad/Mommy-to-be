import 'package:client/src/role/models/role_model.dart';

class RoleArgument {
  final Role? role;
  final bool edit;
  final bool create;
  RoleArgument({this.role, this.edit = false, this.create = false});
}
