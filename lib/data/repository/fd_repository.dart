import '../../domain/models/fd_highlights.dart';
import '../../domain/models/fd_plan.dart';

abstract class FDRepository {
  Future<List<FDPlan>> fetchFDPlans();
  Future<List<FDHighlight>> fetchFDHighlights();
}
