import 'package:my_app/Models/Step.dart';
import 'package:my_app/Models/User.dart';

class Post {
  User? originalPoster;
  Step? firstStep;
  String description;
  String imagenPreview;
  int id;
  String serverName; //server where post is stored
  String description;

  Post(
      {required this.originalPoster,
      required this.firstStep,
      required this.description,
      required this.imagenPreview,
      required this.id,
      required this.serverName,
      required this.description});

  User? getOriginalPoster() {
    return originalPoster;
  }

  void setOriginalPoster(User user) {
    originalPoster = user;
  }

  Step? getFirstStep() {
    return firstStep;
  }

  void setFirstStep(Step? step) {
    firstStep = step;
  }

  int getId() {
    return id;
  }

  void setId(int newId) {
    id = newId;
  }

  String getServerName() {
    return serverName;
  }

  void setServerName(String newServerName) {
    serverName = newServerName;
  }
  String getDescription() {
    return description;
  }

  void setDescription(String newDescription) {
    description = newDescription;
  }
    
   factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
        originalPoster: null,
        firstStep: null,
        description: data['description'],
        imagenPreview: data['image'],
        id: data['id'],
        serverName: data['serverName'],
        description: data['description']);
  }

  static User jsonToUser(Map<String, dynamic> datad) {
    return User(
        id: datad['id'],
        displayName: datad['displayName'],
        email: datad['email'],
        password: datad['password'],
        serverName: datad['serverName'],
        description: datad['description'],
        image: datad['image'],
        imagefield: '');
  }

  static Step jsonToStep(Map<String, dynamic> datad) {
    return Step(
        id: datad['id'],
        previousStep: datad['previousStep'],
        postId: datad['postid'],
        description: datad['description'],
        image: datad['image']);
  }

  static Post cosa(Map<String, dynamic> data) {
    var p = Post.fromJson(data);
    p.setFirstStep(jsonToStep(data['firstStep']));
    p.setOriginalPoster(jsonToUser(data['creator']));
    return p;
  }
}
