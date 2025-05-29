import 'package:flutter/material.dart';

class FDResultCard extends StatelessWidget {
  final double interest;
  final double maturity;

  const FDResultCard({super.key, required this.interest, required this.maturity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Result", style: Theme.of(context).textTheme.titleMedium),
            const Divider(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Interest Earned"),
              Text("₹${interest.toStringAsFixed(2)}"),
            ]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Maturity Amount"),
              Text("₹${maturity.toStringAsFixed(2)}"),
            ]),
          ],
        ),
      ),
    );
  }
}
