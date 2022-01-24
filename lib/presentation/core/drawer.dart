import 'package:auth_userlist_chat/presentation/chat/chat_page.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/user_list_page.dart';
import 'package:flutter/material.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Theme.of(context).primaryColorLight,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'User editor',
              style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push<void>(UserListPage.route());
            },
          ),
          ListTile(
            title: const Text(
              'Chat',
              style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push<void>(ChatPage.route());
            },
          ),
        ],
      ),
    );
  }
}
