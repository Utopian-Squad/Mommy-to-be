import 'package:client/src/mom/models/user.dart';
import 'package:client/src/user_list/bloc/bloc.dart';
import 'package:client/src/user_list/repository/user_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserEvent, UserListState> {
  final UserListRepository userListRepository;

  UserListBloc({required this.userListRepository})
      : super(UserListStateInitial());

  @override
  Stream<UserListState> mapEventToState(UserEvent event) async* {
    if (event is UserListEvent) {
      try {
        final List<dynamic> users = await userListRepository.getUserList();
        if (users == []) {
          yield UserListStateLoading();
        } else {
          yield UserListStateLoaded(users: users);
        }
      } catch (e) {
        yield UserListStateError(error: e.toString());
      }
    }

    if (event is UpdateUserEvent) {
      try {
        print("${event.userId!} ${event.roleId!}");
        await userListRepository.updateUser(event.userId!, event.roleId!);
        yield UpdateUserRole();
      } catch (e) {}
    }
  }
}
