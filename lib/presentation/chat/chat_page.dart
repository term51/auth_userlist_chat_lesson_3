import 'package:auth_userlist_chat/application/auth/auth_bloc.dart';
import 'package:auth_userlist_chat/application/chat/chat_cubit.dart';
import 'package:auth_userlist_chat/presentation/chat/widgets/chat_template.dart';
import 'package:auth_userlist_chat/presentation/chat/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_userlist_chat/presentation/chat/widgets/icon_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChatPage());
  }

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatPage> {
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('created_at', descending: true)
      .snapshots();

  final ScrollController _scrollController = ScrollController();

  final CollectionReference _messagesCollection = FirebaseFirestore.instance.collection('messages');
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: StreamBuilder<QuerySnapshot>(
        stream: _messagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const ChatTemplate(
              body: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ChatTemplate(body: Center(child: CircularProgressIndicator()));
          }

          return BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              void _sendMessage() {
                _messagesCollection.add({
                  'text': context.read<ChatCubit>().state.message,
                  'file': '',
                  'senderId': context.read<AuthBloc>().state.user.id,
                  'created_at': FieldValue.serverTimestamp()
                }).then((value) {
                  _messageController.clear();
                  context.read<ChatCubit>().setReadyToSend(false);
                }).catchError(
                  (error) => print("Failed to add user: $error"),
                );
              }

              return ChatTemplate(
                body: NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) {
                    context.read<ChatCubit>().calculateScrollMetrics(notification);
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ListView(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.all(8),
                      children: snapshot.data!.docs.map((DocumentSnapshot messageData) {
                        return MessageItem(messageData: messageData);
                      }).toList(),
                    ),
                  ),
                ),
                floatingActionButton: context.read<ChatCubit>().state.isChatScrolled
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: FloatingActionButton(
                          onPressed: () => context.read<ChatCubit>().scrollDown(_scrollController),
                          backgroundColor: Colors.white,
                          mini: true,
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : null,
                bottomSheet: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const IconButtonWidget(
                        icon: Icons.sticky_note_2_outlined,
                      ),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _messageController,
                            onChanged: (text) {
                              if (text.isEmpty) {
                                context.read<ChatCubit>().setReadyToSend(false);
                              } else if (context.read<ChatCubit>().state.isReadyToSend != true) {
                                context.read<ChatCubit>().setReadyToSend(true);
                              }
                              context.read<ChatCubit>().messageChanged(text);
                            },
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                              hintText: 'Message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      if (!context.read<ChatCubit>().state.isReadyToSend)
                        const Expanded(
                          flex: 1,
                          child: IconButtonWidget(
                            icon: Icons.attach_file_outlined,
                          ),
                        ),
                      if (!context.read<ChatCubit>().state.isReadyToSend)
                        const Expanded(
                          flex: 1,
                          child: IconButtonWidget(
                            icon: Icons.mic_none,
                          ),
                        ),
                      if (context.read<ChatCubit>().state.isReadyToSend)
                        Expanded(
                          flex: 1,
                          child: IconButtonWidget(
                            callback: _sendMessage,
                            icon: Icons.send,
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
