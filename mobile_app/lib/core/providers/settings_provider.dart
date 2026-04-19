import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import '../theme/app_theme.dart';

class SettingsState extends Equatable {
  final ThemePalette palette;
  final Locale locale;
  final bool notificationsEnabled;
  final bool isFounderPass;

  const SettingsState({
    this.palette = ThemePalette.indigo,
    this.locale = const Locale('en'),
    this.notificationsEnabled = true,
    this.isFounderPass = false,
  });

  SettingsState copyWith({
    ThemePalette? palette,
    Locale? locale,
    bool? notificationsEnabled,
    bool? isFounderPass,
  }) {
    return SettingsState(
      palette: palette ?? this.palette,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isFounderPass: isFounderPass ?? this.isFounderPass,
    );
  }

  @override
  List<Object?> get props => [palette, locale, notificationsEnabled, isFounderPass];
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  static const String _founderKey = 'is_founder_pass';

  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final paletteIndex = prefs.getInt('theme_palette') ?? 0;
    final localeCode = prefs.getString('language_code') ?? 'en';
    final notifications = prefs.getBool('notifications_enabled') ?? true;
    final founder = prefs.getBool(_founderKey) ?? false;
    
    state = SettingsState(
      palette: ThemePalette.values[paletteIndex],
      locale: Locale(localeCode),
      notificationsEnabled: notifications,
      isFounderPass: founder,
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

  Future<void> setFounderPass(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_founderKey, value);
    state = state.copyWith(isFounderPass: value);
  }

  Future<void> setNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    state = state.copyWith(notificationsEnabled: value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
