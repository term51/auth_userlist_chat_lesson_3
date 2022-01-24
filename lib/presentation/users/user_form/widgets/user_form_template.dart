import 'package:flutter/material.dart';

class UserFormTemplate extends StatelessWidget {
  final Widget body;
  final List<Widget>? persistentFooterButtons;

  const UserFormTemplate({Key? key, required this.body, this.persistentFooterButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User editor'),
        ),
        body: body,
        persistentFooterButtons: persistentFooterButtons);
  }
}
