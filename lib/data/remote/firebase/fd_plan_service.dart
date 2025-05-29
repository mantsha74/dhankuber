import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/models/fd_plan.dart';

class FDPlanService {
  final _db = FirebaseFirestore.instance;

  Future<List<FDPlan>> fetchFDPlans() async {
    final snapshot = await _db.collection('fd_plans').get();
    return snapshot.docs.map((doc) => FDPlan.fromMap(doc.data())).toList();
  }
}
