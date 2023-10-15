import 'package:my_app/Models/Step.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoStep.dart';

class RepoStep implements IRepoStep{
  
  @override
  void create(Step t) {
    // TODO: implement create
  }

  @override
  Step read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  void update(Step t) {
    // TODO: implement update
  }

  void delete(Step t) {
    // TODO: implement delete
  }
}