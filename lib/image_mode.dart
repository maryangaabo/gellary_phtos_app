class ImageModel {
  String? image;
  ImageModel({
    required this.image,
  });
  ImageModel.fromjson(Map<String, dynamic> json) {
    image = json["imageUrl"];

  }
}
