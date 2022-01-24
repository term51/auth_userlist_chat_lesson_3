class User {
  final String id;
  final String? email;
  final String? name;

  const User({
    required this.id,
    this.email,
    this.name,
  });

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
