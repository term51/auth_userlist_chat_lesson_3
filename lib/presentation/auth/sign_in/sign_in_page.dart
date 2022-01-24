import 'package:auth_userlist_chat/application/auth/sign_in_form/sign_in_form_cubit.dart';
import 'package:auth_userlist_chat/infrastructure/auth/auth_repository.dart';
import 'package:auth_userlist_chat/presentation/auth/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => SignInFormCubit(context.read<AuthRepository>()),
          child: const SignInForm(),
        ),
      ),
    );
  }
}
