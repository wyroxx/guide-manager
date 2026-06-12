import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const themeModePreferenceKey = 'theme_mode';

final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main');
});

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  late final SharedPreferencesWithCache _preferences;

  @override
  ThemeMode build() {
    _preferences = ref.watch(sharedPreferencesProvider);
    final savedMode = _preferences.getString(themeModePreferenceKey);

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == savedMode,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    if (state == mode) return;

    state = mode;
    await _preferences.setString(themeModePreferenceKey, mode.name);
  }
}
