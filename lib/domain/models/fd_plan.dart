class FDPlan {
  final String name;
  final String logo;
  final String type;
  final Map<String, String> tenures;

  FDPlan({
    required this.name,
    required this.logo,
    required this.type,
    required this.tenures,
  });

  factory FDPlan.fromMap(Map<String, dynamic> map) {
    return FDPlan(
      name: map['bankName'] ?? '',
      logo: map['logo'] ?? '',
      type: map['type'] ?? 'Regular',
      tenures: Map<String, String>.from(map['tenures'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankName': name,
      'logo': logo,
      'type': type,
      'tenures': tenures,
    };
  }

  String? getRate(String tenure) => tenures[tenure];
}
