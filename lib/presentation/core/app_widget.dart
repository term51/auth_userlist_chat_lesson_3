import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';
import 'package:auth_userlist_chat/infrastructure/auth/auth_repository.dart';
import 'package:auth_userlist_chat/presentation/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_userlist_chat/presentation/core/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      title: 'Telegram',
      debugShowCheckedModeBanner: false,
      theme: theme,
    );
  }
}
