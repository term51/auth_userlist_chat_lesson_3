import 'package:auth_userlist_chat/presentation/users/user_form/widgets/input.dart';
import 'package:auth_userlist_chat/presentation/users/user_form/widgets/user_form_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserFormPage extends StatefulWidget {
  final String? documentId;

  const UserFormPage({Key? key, this.documentId}) : super(key: key);

  static Route route({String? documentId}) {
    return MaterialPageRoute<void>(builder: (_) => UserFormPage(documentId: documentId));
  }

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  CollectionReference userCollection = FirebaseFirestore.instance.collection('user-collection');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userId = widget.documentId;

    void _saveUser() {
      if (_formKey.currentState!.validate()) {
        if (userId != null) {

          userCollection
              .doc(userId)
              .update({
                'username': _usernameController.text,
                'firstname': _firstnameController.text,
                'lastname': _lastnameController.text,
                'phone': _phoneController.text
              })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                (error) => print("Failed to update user: $error"),
              );
        } else {
          userCollection
              .add({
                'username': _usernameController.text,
                'firstname': _firstnameController.text,
                'lastname': _lastnameController.text,
                'phone': _phoneController.text
              })
              .then((value) => Navigator.of(context).pop())
              .catchError(
                (error) => print("Failed to add user: $error"),
              );
        }
      }
    }

    return FutureBuilder<DocumentSnapshot>(
      future: userCollection.doc(userId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const UserFormTemplate(
            body: Text(
              "Something went wrong",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const UserFormTemplate(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
          if (data != null) {
            _usernameController.text = data['username'];
            _firstnameController.text = data['firstname'];
            _lastnameController.text = data['lastname'];
            _phoneController.text = data['phone'];
          }
        }

        return UserFormTemplate(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputWidget(hint: 'User name', controller: _usernameController),
                    InputWidget(hint: 'First name', controller: _firstnameController),
                    InputWidget(hint: 'Last name', controller: _lastnameController),
                    InputWidget(hint: 'Phone', controller: _phoneController),
                  ],
                ),
              ),
            ),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: _saveUser,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(Colors.green),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(Colors.redAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
