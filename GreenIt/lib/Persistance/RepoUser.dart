import 'package:my_app/Models/user.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoUser.dart';
import 'package:my_app/Persistance/ServerConnect.dart';

class RepoUser implements IRepoUser {
  ServerConnect server = ServerConnect();

  @override
  void create(User t) {
    try {
      server.insertData("http://16.170.159.93/register?email=" +
          t.email +
          "&password=" +
          t.password +
          "&username=" +
          t.displayName);
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Future<User> read(String email) async {
    User u;
    try {
      var data =
          await server.fetchData("http://16.170.159.93/user?email=" + email);
      u = User(
          displayName: data['displayName'],
          email: data['email'],
          password: data['password'],
          serverName: data['serverName']);
    } catch (e) {
      print("An error occurred: $e");
      u = User(
          displayName: "displayName",
          email: email,
          password: "password",
          serverName: "serverName");
    }

    return u;
  }

  @override
  void update(User t) {
    // TODO: implement update
  }

  void delete(User t) {
    // TODO: implement delete
  }
}
