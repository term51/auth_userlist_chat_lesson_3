import 'package:auth_userlist_chat/application/users/user_list/user_list_cubit.dart';
import 'package:auth_userlist_chat/infrastructure/users/users_repository.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: UserListPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserListPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserListCubit(UsersRepository()),
      child: const UserList(),
    );
  }
}
