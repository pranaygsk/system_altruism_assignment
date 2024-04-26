class ImageModel{
  final String thumbnail;

  ImageModel({required this.thumbnail});

  factory ImageModel.fromJson(Map<String, dynamic> json){
    return ImageModel(thumbnail: json['thumbnail']);
  }
}