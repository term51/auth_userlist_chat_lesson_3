part of 'user_form_cubit.dart';

class UserFormState extends Equatable {
  final Username username;
  final Firstname firstname;
  final Lastname lastname;
  final Phone phone;
  final FormzStatus status;
  final String? errorMessage;
  final String? userId;

  const UserFormState({
    this.username = const Username.pure(),
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.userId,
  });

  @override
  List<Object> get props => [username, firstname, lastname, phone, status];

  UserFormState copyWith({
    Username? username,
    Firstname? firstname,
    Lastname? lastname,
    Phone? phone,
    FormzStatus? status,
    String? errorMessage,
    String? userId,
  }) {
    return UserFormState(
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
    );
  }
}
