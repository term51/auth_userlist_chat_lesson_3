part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.message = '',
    // this.messageList,
    this.isReadyToSend = false,
    this.isChatScrolled = false,
  });

  final String message;
  // final List<Message>? messageList;

  final bool isReadyToSend;
  final bool isChatScrolled;

  @override
  List<Object> get props => [message, isReadyToSend, isChatScrolled];

  ChatState copyWith({
    String? message,
    // List<Message>? messageList,
    bool? isReadyToSend,
    bool? isChatScrolled,
  }) {
    return ChatState(
      message: message ?? this.message,
      // messageList: messageList ?? this.messageList,
      isReadyToSend: isReadyToSend ?? this.isReadyToSend,
      isChatScrolled: isChatScrolled ?? this.isChatScrolled,
    );
  }
}
