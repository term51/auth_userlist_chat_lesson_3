import 'package:auth_userlist_chat/application/users/user_list/user_list_cubit.dart';
import 'package:auth_userlist_chat/presentation/users/user_form/user_page.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/widgets/user_list_item.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/widgets/user_list_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.read<UserListCubit>().getUsers(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const UserListTemplate(
            body: Text(
              "Something went wrong",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const UserListTemplate(body: Center(child: CircularProgressIndicator()));
        }

        return UserListTemplate(
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return UserListItem(doc: document);
            }).toList(),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => context.read<UserListCubit>().toggleDelete(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(Colors.redAccent),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).push<void>(UserPage.route());
                  },
                  child: const Text(
                    'Add user data',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
