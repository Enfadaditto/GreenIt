import 'package:my_app/models/user.dart';

class UserPreferences {
  static User myUser = User(
    imagePath:
        'https://assets.laliga.com/squad/2023/t178/p56764/2048x2225/p56764_t178_2023_1_001_000.png',
    name: 'Robert Lewandowski',
    email: 'lewandowski@gmail.com',
    password: 'password',
    following: List.empty(),
    followers: List.empty(),
  );
}
