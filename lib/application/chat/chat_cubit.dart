import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  void messageChanged(String value) {
    emit(state.copyWith(
      message: value,
    ));
  }

  void scrollDown(ScrollController _scrollController) {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );

    emit(state.copyWith(isChatScrolled: false));
  }

  void calculateScrollMetrics(ScrollEndNotification notification) {
    emit(state.copyWith(isChatScrolled: notification.metrics.extentBefore > 100));
  }

  void setReadyToSend(bool value) {
    emit(state.copyWith(isReadyToSend: value));
  }
}
