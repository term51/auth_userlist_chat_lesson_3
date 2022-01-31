import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';
import 'package:auth_userlist_chat/presentation/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTemplate extends StatelessWidget {
  final Widget body;

  final Widget? floatingActionButton;

  final Widget? bottomSheet;

  const ChatTemplate({Key? key, required this.body, this.floatingActionButton, this.bottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingActionButton,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.emoji_people),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Chat'),
                  Text('Last seen date', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AuthBloc>().add(AppLogoutRequested());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })
          ],
        ),
        drawer: const DefaultDrawer(),
        body: body,
        bottomSheet: bottomSheet);
  }
}
