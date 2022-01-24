import 'package:auth_userlist_chat/presentation/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';

class UserListTemplate extends StatelessWidget {
  final Widget body;
  final List<Widget>? persistentFooterButtons;

  const UserListTemplate({Key? key, required this.body, this.persistentFooterButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User collection'),
        actions: <Widget>[
          IconButton(
              // key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(AppLogoutRequested());
                Navigator.of(context).popUntil((route) => route.isFirst);
              })
        ],
      ),
      drawer: const DefaultDrawer(),
      body: body,
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}
