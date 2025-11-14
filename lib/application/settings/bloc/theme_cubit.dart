import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Theme cubit to manage theme mode with persistence
class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  /// Toggle between light and dark theme
  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      emit(ThemeMode.system);
    } else {
      emit(ThemeMode.light);
    }
  }

  /// Set theme mode explicitly
  void setThemeMode(ThemeMode mode) {
    emit(mode);
  }

  /// Set light theme
  void setLightTheme() {
    emit(ThemeMode.light);
  }

  /// Set dark theme
  void setDarkTheme() {
    emit(ThemeMode.dark);
  }

  /// Set system theme
  void setSystemTheme() {
    emit(ThemeMode.system);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final themeIndex = json['themeMode'] as int?;
    if (themeIndex == null) return ThemeMode.system;
    return ThemeMode.values[themeIndex];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.index};
  }
}

