class User {
  final String imagePath;
  final String name;
  final String email;
  final String password;
  List<String> imagesList;
  List<User> following;
  List<User> followers;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.password,
    required this.imagesList,
    required this.following,
    required this.followers,
  });
}
