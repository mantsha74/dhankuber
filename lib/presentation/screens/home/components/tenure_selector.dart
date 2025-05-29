import 'package:flutter/material.dart';

class TenureSelector extends StatelessWidget {
  final List<String> tenures;
  final String selectedTenure;
  final void Function(String) onSelected;

  const TenureSelector({
    super.key,
    required this.tenures,
    required this.selectedTenure,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: tenures.map((tenure) {
        return ChoiceChip(
          label: Text(tenure),
          selected: tenure == selectedTenure,
          onSelected: (_) => onSelected(tenure),
        );
      }).toList(),
    );
  }
}
