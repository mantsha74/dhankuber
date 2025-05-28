import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, String>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<String> {
  HomeViewModel() : super("Welcome to Home!");

  void updateMessage(String newMessage) {
    state = newMessage;
  }
}
