import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const InputWidget({Key? key, required this.hint, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter value';
          }

          return null;
        },
        controller: controller,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: hint,
        ),
      ),
    );
  }
}
