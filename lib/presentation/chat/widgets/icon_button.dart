import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({Key? key, required this.icon, this.callback}) : super(key: key);

  final Function()? callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.grey,
      onPressed: () {
        if (callback != null) {
          callback!();
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('The functionality is not working yet'),
              ),
            );
        }
      },
      icon: Icon(icon),
    );
  }
}
