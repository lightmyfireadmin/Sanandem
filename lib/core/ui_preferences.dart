import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiPreferencesState {
  final bool isLowPerformanceMode;

  const UiPreferencesState({
    this.isLowPerformanceMode = false,
  });

  UiPreferencesState copyWith({
    bool? isLowPerformanceMode,
  }) {
    return UiPreferencesState(
      isLowPerformanceMode: isLowPerformanceMode ?? this.isLowPerformanceMode,
    );
  }
}

class UiPreferencesNotifier extends StateNotifier<UiPreferencesState> {
  UiPreferencesNotifier() : super(const UiPreferencesState()) {
    _loadPreferences();
  }

  static const _keyIsLowPerformanceMode = 'isLowPerformanceMode';

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isLowPerf = prefs.getBool(_keyIsLowPerformanceMode) ?? false;
    state = state.copyWith(isLowPerformanceMode: isLowPerf);
  }

  Future<void> setLowPerformanceMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLowPerformanceMode, value);
    state = state.copyWith(isLowPerformanceMode: value);
  }
}

final uiPreferencesProvider =
    StateNotifierProvider<UiPreferencesNotifier, UiPreferencesState>((ref) {
  return UiPreferencesNotifier();
});
