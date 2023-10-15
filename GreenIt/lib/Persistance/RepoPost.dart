import 'package:my_app/Models/Post.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoPost.dart';

class RepoPost implements IRepoPost{
  
  @override
  void create(Post t) {
    // TODO: implement create
  }

  @override
  Post read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  void update(Post t) {
    // TODO: implement update
  }

  void delete(Post t) {
    // TODO: implement delete
  }
}