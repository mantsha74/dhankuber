import 'package:flutter/material.dart';

class TrustSection extends StatelessWidget {
  const TrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final trustPoints = [
      {'icon': Icons.verified, 'label': '100% RBI-Approved FDs'},
      {'icon': Icons.lock_outline, 'label': 'Data Privacy & Encryption'},
      {'icon': Icons.money_off, 'label': 'No Commission or Hidden Fees'},
      {'icon': Icons.shield_outlined, 'label': '₹5L DICGC Insurance Cover'},
      {'icon': Icons.bar_chart, 'label': 'Transparent Returns'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Why Trust Dhankuber?",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...trustPoints.map(
              (item) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, size: 26, color: theme.colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item['label'] as String,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
