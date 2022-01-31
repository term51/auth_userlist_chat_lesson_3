import 'package:auth_userlist_chat/infrastructure/users/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:auth_userlist_chat/domain/users/firstname.dart';
import 'package:auth_userlist_chat/domain/users/lastname.dart';
import 'package:auth_userlist_chat/domain/users/username.dart';
import 'package:auth_userlist_chat/domain/users/phone.dart';

part 'user_form_state.dart';

class UserFormCubit extends Cubit<UserFormState> {
  final UsersRepository _usersRepository;

  UserFormCubit(this._usersRepository) : super(const UserFormState());

  void setUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.lastname, state.phone, state.firstname]),
    ));
  }

  void firstnameChanged(String value) {
    final firstname = Firstname.dirty(value);
    emit(state.copyWith(
      firstname: firstname,
      status: Formz.validate([firstname, state.lastname, state.phone, state.username]),
    ));
  }

  void lastnameChanged(String value) {
    final lastname = Lastname.dirty(value);
    emit(state.copyWith(
      lastname: lastname,
      status: Formz.validate([lastname, state.firstname, state.phone, state.username]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone, state.firstname, state.lastname, state.username]),
    ));
  }

  Future<DocumentSnapshot> getUser() async {
    return _usersRepository.getUser(userId: state.userId);
  }

  Future<void> saveUser() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (state.userId != null) {
        await _usersRepository.updateUser(
            userId: state.userId!,
            username: state.username.value,
            firstname: state.firstname.value,
            lastname: state.lastname.value,
            phone: state.phone.value);
      } else {
        await _usersRepository.addUser(
          username: state.username.value,
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          phone: state.phone.value,
        );
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
