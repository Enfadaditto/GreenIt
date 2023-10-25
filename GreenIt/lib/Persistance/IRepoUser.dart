import 'package:my_app/Models/user.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoUser implements IGenericRepository<User> {
  @override
  void create(User t);

  @override
  Future<User> read(String id);

  @override
  void update(User t);

  void delete(User t);
}
