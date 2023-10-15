import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoUser.dart';

class RepoUser implements IRepoUser{
  
  @override
  void create(User t) {
    // TODO: implement create
  }

  @override
  User read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  void update(User t) {
    // TODO: implement update
  }

  void delete(User t) {
    // TODO: implement delete
  }
}