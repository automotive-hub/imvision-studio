class Ads {
  Ads({
    required this.desktopVideo,
    required this.mobileVideo,
  });

  Ads.fromJson(Map<String, Object?> json)
      : this(
          desktopVideo: json['desktop_video']! as String,
          mobileVideo: json['mobile_video']! as String,
        );

  final String desktopVideo;
  final String mobileVideo;

  Map<String, Object?> toJson() {
    return {
      'desktop_video': desktopVideo,
      'mobile_video': mobileVideo,
    };
  }
}
