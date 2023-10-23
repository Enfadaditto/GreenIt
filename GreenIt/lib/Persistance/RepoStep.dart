import 'package:my_app/Models/Step.dart';
import 'package:my_app/Persistance/IGenericRepository.dart';
import 'package:my_app/Persistance/IRepoStep.dart';

import 'ServerConnect.dart';

class RepoStep implements IRepoStep{

  ServerConnect server = ServerConnect();
  
  @override
  void create(Step t) {
    // TODO: implement create
  }

  @override
  Future<Step> read(String id) async{
    Step s;
    try {
      var data = await server.fetchData("http://13.49.72.206/step?id" + id);
      s = Step(id: data['id'], previousStep: data['previousStep'], description: data['description'], image: data['image']);
      return s;
    } catch (e) {
      print("An error occurred: $e");
      return Step(id: 'id', previousStep: null, description: 'description', image: 'image');
    }
  }

  @override
  void update(Step t) {
    // TODO: implement update
  }

  void delete(Step t) {
    // TODO: implement delete
  }
}