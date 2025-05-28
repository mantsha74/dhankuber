import 'package:flutter/material.dart';

import '../../core/widgets/fd_card.dart';
import '../../data/sample/fd_sample.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tenures = ['12M', '18M', '24M', '30M', '36M', '42M', '50M', '60M'];
  String selectedTenure = '18M';

  @override
  Widget build(BuildContext context) {
    final filteredFDs = fdPlans.where((fd) => fd.tenure == selectedTenure || fd.tenure == 'N.A').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("LETS GET STARTED", style: TextStyle(color: Colors.green)),
              const SizedBox(height: 8),
              const Text("Compare Fixed Deposit Interest Rates", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Select FD Tenure (Year - Yr, Month - Mn)", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _buildTenureChips(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredFDs.length,
                  itemBuilder: (context, index) {
                    return FDCard(fd: filteredFDs[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenureChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tenures.map((tenure) {
          final isSelected = tenure == selectedTenure;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(tenure),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => setState(() => selectedTenure = tenure),
              selectedColor: Colors.black,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: isSelected ? Colors.black : Colors.grey.shade300),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
