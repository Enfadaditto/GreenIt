import 'package:my_app/Models/ReducedUser.dart';

class User {
  late int id;

  late String displayName;
  late String email;
  late String password;
  late String serverName;

  late String description;
  late String image;
  late String imagefield;

  User(
      {
      required this.id,
      required this.displayName,
      required this.email,
      required this.password,
      required this.serverName,
      required this.description,
      required this.image,
      required this.imagefield});

  String getDisplayName() {
    return displayName;
  }

  void setDisplayName(String displayName) {
    this.displayName = displayName;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getPassword() {
    return password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getServerName() {
    return serverName;
  }

  void setServerName(String serverName) {
    this.serverName = serverName;
  }

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  get getImagefield => this.imagefield;

  set setImagefield(imagefield) => this.imagefield = imagefield;

  get getId => this.id;

  set setId(id) => this.id = id;

}
