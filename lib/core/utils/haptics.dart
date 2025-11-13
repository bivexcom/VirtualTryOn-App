import 'package:flutter/services.dart';

/// Haptic feedback utility class
/// Provides convenient methods for triggering haptic feedback throughout the app
class Haptics {
  Haptics._();

  /// Light impact feedback
  /// Use for: Success states, AI result ready, subtle confirmations
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact feedback
  /// Use for: Primary actions (generate button, submit), important confirmations
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact feedback
  /// Use for: Critical actions, errors, warnings
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection feedback
  /// Use for: Tab switches, segment changes, picker scrolling
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Vibrate feedback
  /// Use sparingly for special events
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }
}

