import 'package:flutter/material.dart';
import '../../../../domain/models/fd_plan.dart';

class BankDetailScreen extends StatelessWidget {
  final FDPlan plan;

  const BankDetailScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tenures = plan.tenures.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(plan.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: plan.logo.isNotEmpty
                    ? Image.network(
                  plan.logo,
                  height: 50,
                  width: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.account_balance, size: 50),
                )
                    : const Icon(Icons.account_balance, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              plan.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Offered FD Interest Rates", style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),

            // List of rate cards
            ...tenures.map((tenure) {
              final rate = plan.tenures[tenure];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$tenure Tenure", style: theme.textTheme.bodyLarge),
                    Text(
                      "$rate%",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),
            Text("Why Choose This Bank?", style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            const Column(
              children: [
                TrustPoint(icon: Icons.verified, label: "100% RBI-Approved"),
                TrustPoint(icon: Icons.lock, label: "Secure & Private"),
                TrustPoint(icon: Icons.shield, label: "DICGC ₹5L Insurance Cover"),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              // TODO: Navigate to FD booking screen
            },
            icon: const Icon(Icons.account_balance_wallet),
            label: const Text("Invest Now"),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrustPoint extends StatelessWidget {
  final IconData icon;
  final String label;

  const TrustPoint({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
