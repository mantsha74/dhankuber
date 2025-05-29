import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSampleFDHighlights() async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('fd_highlights');

  final sampleData = [
    {
      'bankName': 'Axis Bank',
      'investmentAmount': '50000',
      'tenure': '12M',
      'estimatedReturn': '3800',
      'rate': '7.6%',
      'priority': 1,
    },
    {
      'bankName': 'HDFC Bank',
      'investmentAmount': '100000',
      'tenure': '24M',
      'estimatedReturn': '8200',
      'rate': '8.0%',
      'priority': 2,
    },
    {
      'bankName': 'SBI',
      'investmentAmount': '75000',
      'tenure': '18M',
      'estimatedReturn': '5400',
      'rate': '7.2%',
      'priority': 3,
    },
  ];

  for (final item in sampleData) {
    await collection.add(item);
  }

  print('Sample FD highlights uploaded.');
}
