import 'package:my_app/Models/Post.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoPost implements IGenericRepository<Post> {
  @override
  void create(Post t);

  @override
  Future<Post> read(String id);

  @override
  void update(Post t);

  void delete(Post t);

  Future<List<Post>> getAllPostsUser(String displayName);
}
