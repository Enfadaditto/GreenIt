import 'package:my_app/Models/Step.dart';
import 'package:my_app/Models/User.dart';

class Post {
  User? originalPoster;
  Step? firstStep;
  String id;
  String serverName; //server where post is stored

  Post(
      {required this.originalPoster,
      required this.firstStep,
      required this.id,
      required this.serverName});

  User? getOriginalPoster() {
    return originalPoster;
  }

  void setOriginalPoster(User user) {
    originalPoster = user;
  }

  Step? getFirstStep() {
    return firstStep;
  }

  void setFirstStep(Step step) {
    firstStep = step;
  }

  String getId() {
    return id;
  }

  void setId(String newId) {
    id = newId;
  }

  String getServerName() {
    return serverName;
  }

  void setServerName(String newServerName) {
    serverName = newServerName;
  }
}
