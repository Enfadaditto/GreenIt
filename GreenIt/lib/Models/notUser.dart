class notUser {
  final String imagePath;
  final String name;
  final String email;
  final String password;
  List<String> imagesList;
  List<notUser> following;
  List<notUser> followers;

  notUser({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.password,
    required this.imagesList,
    required this.following,
    required this.followers,
  });
}
