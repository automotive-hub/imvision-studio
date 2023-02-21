class Status {
  Status(
      {required this.classification,
      required this.download,
      required this.imageTotal,
      required this.imageCounter,
      required this.predictionCounter,
      required this.predictionTotal,
      required this.video});

  Status.fromJson(Map<String, dynamic> json)
      : this(
          classification: json['classification'] ?? '',
          download: json['download'] ?? '',
          imageTotal: json['image_total'] ?? 0,
          imageCounter: json['image_counter'] ?? 0,
          predictionCounter: json['prediction_counter'] ?? 0,
          predictionTotal: json['prediction_total'] ?? 0,
          video: json['video'] ?? '',
        );

  final String classification;
  final String download;
  final int imageCounter;
  final int imageTotal;
  final int predictionCounter;
  final int predictionTotal;

  final String video;

  Map<String, Object?> toJson() {
    return {
      'classification': classification,
      'download': download,
      'image_total': imageTotal,
      'image_counter': imageCounter,
      'prediction_counter': predictionCounter,
      'prediction_total': predictionTotal,
      'video': video,
    };
  }
}
