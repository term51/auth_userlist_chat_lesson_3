class User {
  final String username;
  final String firstname;

  final String lastname;
  final String phoneNumber;

  const User({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
  });

  static const empty = User(username: '', firstname: '', lastname: '', phoneNumber: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
