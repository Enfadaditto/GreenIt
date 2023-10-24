class User {
  final String imagePath;
  final String name;
  final String email;
  final String password;
  List<String> imagesList;
  List<User> following;
  List<User> followers;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.imagePath,
    required this.imagesList,
    List<User>? followers, // Provide an initial empty list
    List<User>? following, // Provide an initial empty list
  })  : followers = followers ?? [],
        following = following ?? [];

  addFollowedUser(User u) {
    following.add(u);
    u.followers.add(this);
  }
}
