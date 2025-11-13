import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Extension on BuildContext for convenient access to common utilities
extension BuildContextExtensions on BuildContext {
  /// Access localization
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Access theme
  ThemeData get theme => Theme.of(this);

  /// Access text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Check if dark mode is active
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Access media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Safe area padding
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Show snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
