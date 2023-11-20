import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoUser implements IGenericRepository<User> {
  @override
  void create(User t);

  Future<void> follow(int follower, int following);

  @override
  Future<User> read(String id);

  Future<User> readName(String name);

  @override
  void update(User t);

  void delete(User t);

  Future<List<ReducedUser>> getFollowers(int userId);

  Future<List<ReducedUser>> getFollowed(int userId);
}
