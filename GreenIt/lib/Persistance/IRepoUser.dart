import 'package:my_app/Models/ReducedUser.dart';
import 'package:my_app/Models/User.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoUser implements IGenericRepository<User> {
  @override
  Future<bool> create(User t);

  @override
  Future<User> read(String id);

  Future<User> readName(String name);

  @override
  void update(User t);

  void delete(User t);

  Future<List<ReducedUser>> getFollowers(int userId);

  Future<List<ReducedUser>> getFollowed(int userId);

  Future<void> follow(int follower, int following);

  Future<void> unfollow(int userId, int unfollowedUserId);

  Future<int> getCountFollowers(int userId);

  Future<int> getCountFollowed(int userId);

  Future<int> getCountPosts(String username);

  Future<bool> checkFollows(int userId, int followedId);
}
