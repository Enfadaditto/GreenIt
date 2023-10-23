import 'package:my_app/Models/Step.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';

abstract class IRepoStep implements IGenericRepository<Step>{
  
  @override
  void create(Step t);

  @override
  Future<Step> read(String id);

  @override
  void update(Step t);

  void delete(Step t);
}