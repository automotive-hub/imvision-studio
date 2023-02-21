class Status {
  Status(
      {required this.classification,
      required this.download,
      required this.imageTotal,
      required this.imageCounter,
      required this.predictionCounter,
      required this.predictionTotal,
      required this.video});

  Status.fromJson(Map<String, Object?> json)
      : this(
          classification: json['classification']! as String,
          download: json['download']! as String,
          imageTotal: json['image_total']! as int,
          imageCounter: json['image_counter']! as int,
          predictionCounter: json['prediction_counter']! as int,
          predictionTotal: json['prediction_total']! as int,
          video: json['video']! as String,
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
