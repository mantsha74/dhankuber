import 'package:flutter/material.dart';

class FDOverviewCard extends StatelessWidget {
  final String investmentAmount;
  final String tenure;
  final String estimatedReturn;
  final String rate;
  final String bankName;

  const FDOverviewCard({
    super.key,
    required this.investmentAmount,
    required this.tenure,
    required this.estimatedReturn,
    required this.rate,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invest ₹$investmentAmount for $tenure",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "Earn up to ₹$estimatedReturn @ $rate",
              style: TextStyle(color: Colors.green[700]),
            ),
            const SizedBox(height: 6),
            Text(
              "$bankName FD",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Navigate to /plans or /compare
                  },
                  child: Text(
                    "Compare All Plans",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    // Navigate to /book-now or specific plan
                  },
                  child: const Text("Know more"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
