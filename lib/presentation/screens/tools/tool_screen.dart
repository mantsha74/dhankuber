import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fd_calculator_screen.dart';

class ToolsScreen extends ConsumerWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tools = [
      {'icon': Icons.calculate, 'label': 'FD Calculator', 'route': const FDCalculatorScreen()},
      {'icon': Icons.list, 'label': 'All FD Plans'},
      {'icon': Icons.bar_chart, 'label': 'Returns Graph'},
      {'icon': Icons.info_outline, 'label': 'How FD Works'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Your Tools')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return InkWell(
              onTap: () {
                if (tool['route'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => tool['route'] as Widget),
                  );
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(tool['icon'] as IconData, size: 40, color: Theme.of(context).primaryColor),
                      const SizedBox(height: 12),
                      Text(tool['label'] as String),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
