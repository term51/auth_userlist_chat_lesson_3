import 'package:auth_userlist_chat/presentation/users/user_form/user_form_page.dart';
import 'package:auth_userlist_chat/presentation/users/user_list/widgets/user_list_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: UserListPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserListPage());
  }

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user-collection').snapshots();
  CollectionReference userCollection = FirebaseFirestore.instance.collection('user-collection');

  bool toggleDelete = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: toggleDelete
                    ? GestureDetector(
                        onTap: () {
                          userCollection
                              .doc(document.id)
                              .delete()
                              .then((value) => print("User Deleted"))
                              .catchError((error) => print("Failed to delete user: $error"));
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      )
                    : null,
                title: Text(data['firstname']),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(data['username']),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Last name: ${data['lastname']}'),
                        Text('First name: ${data['firstname']}'),
                        Text('Phone: ${data['phone']}'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push<void>(
                            UserFormPage.route(documentId: document.id),
                          );
                        },
                        child: const Text('Edit',style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => setState(() {
                          toggleDelete = !toggleDelete;
                        }),
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
                    Navigator.of(context).push<void>(UserFormPage.route());
                  }, // TODO: push to user_form without data
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
