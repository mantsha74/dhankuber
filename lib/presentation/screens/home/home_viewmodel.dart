import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repository/fd_repository.dart';
import '../../../di/service_locator.dart';
import '../../../domain/models/fd_highlights.dart';
import '../../../domain/models/fd_plan.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, AsyncValue<HomeScreenState>>(
      (ref) => HomeViewModel(getIt<FDRepository>()),
);

class HomeScreenState {
  final List<FDPlan> fdPlans;
  final List<FDHighlight> highlights;

  HomeScreenState({required this.fdPlans, required this.highlights});
}

class HomeViewModel extends StateNotifier<AsyncValue<HomeScreenState>> {
  final FDRepository _repository;

  HomeViewModel(this._repository) : super(const AsyncValue.loading()) {
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    try {
      final fdPlans = await _repository.fetchFDPlans();
      final highlights = await _repository.fetchFDHighlights();
      state = AsyncValue.data(HomeScreenState(fdPlans: fdPlans, highlights: highlights));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
