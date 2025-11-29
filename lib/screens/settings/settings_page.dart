import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/ui_preferences.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiPrefs = ref.watch(uiPreferencesProvider);
    final notifier = ref.read(uiPreferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Mode économie d'énergie"),
            subtitle: const Text("Reduces visual effects to improve performance."),
            value: uiPrefs.isLowPerformanceMode,
            onChanged: (value) {
              notifier.setLowPerformanceMode(value);
            },
            secondary: const Icon(Icons.speed),
          ),
        ],
      ),
    );
  }
}
