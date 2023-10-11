class User {
  final String imagePath;
  final String name;
  final String email;
  final String password;
  List<User> following;
  List<User> followers;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.password,
    required this.following,
    required this.followers,
  });
}
