import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tools_viewmodel.dart';
import 'components/fd_result_card.dart';

class FDCalculatorScreen extends ConsumerWidget {
  const FDCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(fdCalculatorProvider);
    final controller = ref.read(fdCalculatorProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FD Calculator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Calculate Returns", style: theme.textTheme.titleMedium),
                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Investment Amount (₹)",
                    prefixIcon: Icon(Icons.currency_rupee),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: controller.updateAmount,
                ),

                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Interest Rate (%)",
                    prefixIcon: Icon(Icons.percent),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: controller.updateRate,
                ),

                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Tenure (months)",
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: controller.updateTenure,
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: controller.calculate,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text("Calculate"),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                if (viewModel.interestEarned != null && viewModel.maturityAmount != null)
                  FDResultCard(
                    interest: viewModel.interestEarned!,
                    maturity: viewModel.maturityAmount!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
