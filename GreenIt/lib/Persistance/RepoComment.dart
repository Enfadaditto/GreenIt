import 'package:my_app/Models/Comment.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoComment.dart';

class RepoComment implements IRepoComment{
  
  @override
  void create(Comment t) {
    // TODO: implement create
  }

  @override
  Comment read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  void update(Comment t) {
    // TODO: implement update
  }

  void delete(Comment t) {
    // TODO: implement delete
  }
}