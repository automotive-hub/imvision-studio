class Status {
  Status(
      {required this.classification,
      required this.download,
      required this.image,
      required this.video});

  Status.fromJson(Map<String, Object?> json)
      : this(
          classification: json['classification']! as String,
          download: json['download']! as String,
          image: json['image']! as int,
          video: json['video']! as String,
        );

  final String classification;
  final String download;
  final int image;
  final String video;

  Map<String, Object?> toJson() {
    return {
      'classification': classification,
      'download': download,
      'image': image,
      'video': video,
    };
  }
}
