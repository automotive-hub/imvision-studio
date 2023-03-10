class Ads {
  Ads({
    required this.desktopVideoRef,
    required this.mobileVideoRef,
    required this.gifRef,
    required this.bannerRef,
  });

  Ads.fromJson(Map<String, dynamic> json)
      : this(
          desktopVideoRef: json['desktop_video_ref'] ?? '',
          mobileVideoRef: json['mobile_video_ref'] ?? '',
          gifRef: json['gif_ref'] ?? '',
          bannerRef: json['banner_ref'] ?? '',
        );

  final String desktopVideoRef;
  final String mobileVideoRef;
  final String gifRef;
  final String bannerRef;

  Map<String, Object?> toJson() {
    return {
      'desktop_video_ref': desktopVideoRef,
      'mobile_video_ref': mobileVideoRef,
      'gif_ref': gifRef,
      'banner_ref': bannerRef,
    };
  }
}
