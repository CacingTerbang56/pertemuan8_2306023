class PictModel {
  final String id;
  final String author;
  final String downloadUrl;

  PictModel({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  factory PictModel.fromJson(Map<String, dynamic> json) {
    return PictModel(
      id: json['id'],
      author: json['author'],
      downloadUrl: json['download_url'],
    );
  }
}