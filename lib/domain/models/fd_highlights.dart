class FDHighlight {
  final String bankName;
  final String investmentAmount;
  final String tenure;
  final String estimatedReturn;
  final String rate;

  FDHighlight({
    required this.bankName,
    required this.investmentAmount,
    required this.tenure,
    required this.estimatedReturn,
    required this.rate,
  });

  factory FDHighlight.fromMap(Map<String, dynamic> map) {
    return FDHighlight(
      bankName: map['bankName'] ?? '',
      investmentAmount: map['investmentAmount'] ?? '',
      tenure: map['tenure'] ?? '',
      estimatedReturn: map['estimatedReturn'] ?? '',
      rate: map['rate'] ?? '',
    );
  }
}
