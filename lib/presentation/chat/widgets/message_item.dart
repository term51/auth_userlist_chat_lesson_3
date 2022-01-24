import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.messageData}) : super(key: key);
  final DocumentSnapshot messageData;

  @override
  Widget build(BuildContext context) {
    final _currentUser = context.read<AuthBloc>().state.user;
    Map<String, dynamic> _messageData = messageData.data()! as Map<String, dynamic>;

    String _time = '';
    if (_messageData['created_at'] != null) {
      DateTime _dt = (_messageData['created_at'] as Timestamp).toDate();
      _time = DateFormat('HH:mm').format(_dt);
    }

    bool _isISender = _messageData['senderId'] == _currentUser.id;

    return Card(
      margin: _isISender
          ? const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 80)
          : const EdgeInsets.only(bottom: 5, top: 5, right: 80, left: 10),
      color: _isISender ? const Color.fromRGBO(202, 255, 191, 1) : Colors.white,
      elevation: 0.5,
      shadowColor: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Linkify(
              text: _messageData['text'],
              style: const TextStyle(fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _time,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Icon(Icons.check_outlined, color: Colors.blueGrey, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
