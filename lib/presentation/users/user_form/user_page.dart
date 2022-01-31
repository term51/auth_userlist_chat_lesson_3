import 'package:auth_userlist_chat/application/users/user_form/user_form_cubit.dart';
import 'package:auth_userlist_chat/infrastructure/users/users_repository.dart';
import 'package:auth_userlist_chat/presentation/users/user_form/widgets/user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  static Route route({String? documentId}) {
    return MaterialPageRoute<void>(builder: (_) => UserPage(documentId: documentId));
  }

  final String? documentId;

  const UserPage({Key? key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserFormCubit(UsersRepository()),
      child: UserForm(
        documentId: documentId,
      ),
    );
  }
}
