import 'package:flutter_riverpod/flutter_riverpod.dart';

final fdCalculatorProvider = StateNotifierProvider<FDCalculatorViewModel, FDCalculatorState>(
      (ref) => FDCalculatorViewModel(),
);

class FDCalculatorState {
  final String amount;
  final String rate;
  final String tenure;
  final double? interestEarned;
  final double? maturityAmount;

  FDCalculatorState({
    this.amount = '',
    this.rate = '',
    this.tenure = '',
    this.interestEarned,
    this.maturityAmount,
  });

  FDCalculatorState copyWith({
    String? amount,
    String? rate,
    String? tenure,
    double? interestEarned,
    double? maturityAmount,
  }) {
    return FDCalculatorState(
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
      tenure: tenure ?? this.tenure,
      interestEarned: interestEarned,
      maturityAmount: maturityAmount,
    );
  }
}

class FDCalculatorViewModel extends StateNotifier<FDCalculatorState> {
  FDCalculatorViewModel() : super(FDCalculatorState());

  void updateAmount(String value) {
    state = state.copyWith(amount: value);
  }

  void updateRate(String value) {
    state = state.copyWith(rate: value);
  }

  void updateTenure(String value) {
    state = state.copyWith(tenure: value);
  }

  void calculate() {
    final principal = double.tryParse(state.amount) ?? 0;
    final rate = double.tryParse(state.rate) ?? 0;
    final tenure = double.tryParse(state.tenure) ?? 0;

    final interest = (principal * rate * tenure) / (100 * 12);
    final maturity = principal + interest;

    state = state.copyWith(
      interestEarned: interest,
      maturityAmount: maturity,
    );
  }
}
