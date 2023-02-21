class Classification {
  Classification({
    required this.bottomBack,
    required this.bottomLeftPanel,
    required this.bottomRightPanel,
    required this.dashPanel,
    required this.exterior,
    required this.imageWithAdvertisement,
    required this.leftPanel,
    required this.midCenterPoint,
    required this.rightPanel,
  });

  Classification.fromJson(Map<String, dynamic> json)
      : this(
          bottomBack: json['BOTTOM_BACK'] ?? [],
          bottomLeftPanel: json['BOTTOM_LEFT_PANEL'] ?? [],
          bottomRightPanel: json['BOTTOM_RIGTH_PANEL'] ?? [],
          dashPanel: json['DASH_PANEL'] ?? [],
          exterior: json['EXTERIOR'] ?? [],
          imageWithAdvertisement: json['IMAGE_WITH_ADVERTISEMENT']?? [],
          leftPanel: json['LEFT_PANEL'] ?? [],
          midCenterPoint: json['MID_CENTER_POINT'] ?? [],
          rightPanel: json['RIGHT_PANEL'] ?? [],
        );

  final List<dynamic>? bottomBack;
  final List<dynamic>? bottomLeftPanel;
  final List<dynamic>? bottomRightPanel;
  final List<dynamic>? dashPanel;
  final List<dynamic>? exterior;
  final List<dynamic>? imageWithAdvertisement;
  final List<dynamic>? leftPanel;
  final List<dynamic>? midCenterPoint;
  final List<dynamic>? rightPanel;

  Map<String, Object?> toJson() {
    return {
      'BOTTOM_BACK': bottomBack,
      'BOTTOM_LEFT_PANEL': bottomLeftPanel,
      'BOTTOM_RIGTH_PANEL': bottomRightPanel,
      'DASH_PANEL': dashPanel,
      'EXTERIOR': exterior,
      'IMAGE_WITH_ADVERTISEMENT': imageWithAdvertisement,
      'LEFT_PANEL': leftPanel,
      'MID_CENTER_POINT': midCenterPoint,
      'RIGHT_PANEL': rightPanel,
    };
  }
}
