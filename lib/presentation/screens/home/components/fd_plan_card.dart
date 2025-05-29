import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/fd_plan.dart';

class FDPlanCard extends StatelessWidget {
  final FDPlan plan;
  final String selectedTenure;

  const FDPlanCard({
    super.key,
    required this.plan,
    required this.selectedTenure,
  });

  @override
  Widget build(BuildContext context) {
    final rate = plan.getRate(selectedTenure) ?? '--';

    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: plan.logo.isNotEmpty
                      ? Image.network(
                    plan.logo,
                    height: 40,
                    width: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.account_balance, size: 40),
                  )
                      : const Icon(Icons.account_balance, size: 40),
                ),
              ),
              const SizedBox(height: 12),
              Text(plan.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text("$rate% for $selectedTenure"),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: FilledButton(
                  onPressed: () {
                    context.push(
                      '/bank-detail',
                      extra: plan,
                    );
                  },
                  child: const Text("Know more"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
