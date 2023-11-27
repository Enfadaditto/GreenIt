import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoComment implements IGenericRepository<Comment> {
  @override
  void create(Comment t);

  @override
  Future<Comment> read(String id);

  @override
  void update(Comment t);

  void delete(Comment t);

  Future<List<Comment>> getAllCommentsPost(int postId);
}
