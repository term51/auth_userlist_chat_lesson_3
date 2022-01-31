import 'package:auth_userlist_chat/infrastructure/users/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final UsersRepository _usersRepository;

  UserListCubit(this._usersRepository) : super(const UserListState());

  void toggleDelete() {
    emit(state.copyWith(isCanDelete: !state.isCanDelete));
  }

  void deleteUser(String userId) {
    _usersRepository.deleteUser(userId: userId);
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRepository.getUsers();
  }
}
