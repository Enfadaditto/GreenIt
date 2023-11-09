class ReducedUser {
  late int id;
  late String displayName;
  late String image;
  late String imagefield;

  ReducedUser(
      {
      required this.id,
      required this.displayName,
      required this.image,
      required this.imagefield});

  get getId => this.id;

  set setId(id) => this.id;

  get getDisplayName => this.displayName;

  set setDisplayName(displayName) => this.displayName = displayName;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  get getImagefield => this.imagefield;

  set setImagefield(imagefield) => this.imagefield = imagefield;

  factory ReducedUser.fromJson(Map<String, dynamic> json) {
    return ReducedUser(
      id: json['id'],
      displayName: json['displayName'],
      image: json['image'],
      imagefield: json['imagefield']
    );
  }
}
