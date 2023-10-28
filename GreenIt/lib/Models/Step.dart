import 'package:my_app/Models/Comment.dart';

class Step{

  late String id;

  late Step? previousStep;

  late String description;

  late String? image; //path to img

  late List<Comment> comments;

  Step({
    required this.id,
    required this.previousStep,
    required this.description,
    required this.image
  });

  Step? getPreviousStep() {
    return previousStep;
  }

  void setPreviousStep(Step step) {
    previousStep = step;
  }

  String getDescription() {
    return description;
  }

  void setDescription(String desc) {
    description = desc;
  }

  String? getImage() {
    return image;
  }

  void setImage(String imagePath) {
    image = imagePath;
  }

  List<Comment> getComments() {
    return comments;
  }

  void setComments(List<Comment> commentList) {
    comments = commentList;
  }
  
}