import 'package:flutter/material.dart';
import '../../domain/models/fd_plan.dart';

class FDCard extends StatelessWidget {
  final FDPlan fd;

  const FDCard({super.key, required this.fd});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundImage: AssetImage(fd.logo),
          radius: 24,
          backgroundColor: Colors.white,
        ),
        title: Text(fd.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Tenure: ${fd.tenures}"),
            Text("Interest: ${fd.name}", style: const TextStyle(color: Colors.green)),
            Text("Type: ${fd.type}"),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text("Open FD"),
        ),
      ),
    );
  }
}
