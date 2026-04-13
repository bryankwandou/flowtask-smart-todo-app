import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/theme/app_theme.dart';

class SettingsState {
  final ThemePalette palette;
  final Locale locale;

  SettingsState({required this.palette, required this.locale});

  SettingsState copyWith({ThemePalette? palette, Locale? locale}) {
    return SettingsState(
      palette: palette ?? this.palette,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState(palette: ThemePalette.indigo, locale: const Locale('en'))) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final paletteIndex = prefs.getInt('theme_palette') ?? 0;
    final languageCode = prefs.getString('language_code') ?? 'en';
    
    state = SettingsState(
      palette: ThemePalette.values[paletteIndex],
      locale: Locale(languageCode),
    );
  }

  Future<void> setPalette(ThemePalette palette) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_palette', palette.index);
    state = state.copyWith(palette: palette);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    state = state.copyWith(locale: locale);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
