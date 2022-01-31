import 'package:auth_userlist_chat/application/users/user_list/user_list_cubit.dart';
import 'package:auth_userlist_chat/presentation/users/user_form/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListItem extends StatelessWidget {
  final Map<String, dynamic> _data;
  final DocumentSnapshot doc;

  UserListItem({Key? key, required this.doc})
      : _data = doc.data()! as Map<String, dynamic>,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListCubit, UserListState>(
      buildWhen: (previous, current) => previous.isCanDelete != current.isCanDelete,
      builder: (context, state) {
        return ListTile(
          leading: state.isCanDelete
              ? GestureDetector(
                  onTap: () => context.read<UserListCubit>().deleteUser(doc.id),
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                )
              : null,
          title: Text(_data['firstname']),
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_data['username']),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Last name: ${_data['lastname']}'),
                  Text('First name: ${_data['firstname']}'),
                  Text('Phone: ${_data['phone']}'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push<void>(
                      UserPage.route(documentId: doc.id),
                    );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
