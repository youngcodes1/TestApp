class ImageModel {
  final String id;
  final String description;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.description,
    required this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      description: json['description'] ?? 'No description available',
      imageUrl: json['urls']['regular'],
    );
  }
}
