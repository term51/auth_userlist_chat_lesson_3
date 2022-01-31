part of 'user_list_cubit.dart';

class UserListState extends Equatable {
  final bool isCanDelete;

  const UserListState({
    this.isCanDelete = false,
  });

  @override
  List<Object> get props => [isCanDelete];

  UserListState copyWith({
    bool? isCanDelete,
  }) {
    return UserListState(
      isCanDelete: isCanDelete ?? this.isCanDelete,
    );
  }
}
