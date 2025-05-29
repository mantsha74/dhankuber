import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/fd_highlights.dart';
import '../../domain/models/fd_plan.dart';
import '../repository/fd_repository.dart';

class FDRepositoryImpl implements FDRepository {
  final FirebaseFirestore _db;

  FDRepositoryImpl(this._db);

  @override
  Future<List<FDPlan>> fetchFDPlans() async {
    final snapshot = await _db.collection('fd_plans').get();
    return snapshot.docs.map((doc) => FDPlan.fromMap(doc.data())).toList();
  }

  @override
  Future<List<FDHighlight>> fetchFDHighlights() async {
    final snapshot = await _db.collection('fd_highlights').orderBy('priority').get();
    return snapshot.docs.map((doc) => FDHighlight.fromMap(doc.data())).toList();
  }
}
