import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'theme_extensions.dart';

/// Light theme configuration - Neutral Base + Peach Accent
/// Cool-neutral surfaces with warm peach accents for premium fashion tech look
/// Peach is used ONLY for highlights, never for backgrounds
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  // Color Scheme - Neutral Base with Peach Accent
  colorScheme: const ColorScheme.light(
    // Peach accents
    primary: AppColors.primaryPeach, // #E8A98F
    primaryContainer: AppColors.primarySoft, // #F3D4C6
    secondary: AppColors.primarySoft,
    secondaryContainer: AppColors.surfaceVariant,
    tertiary: AppColors.primaryDark,
    
    // Neutral surfaces
    surface: AppColors.surface, // #F0EEEB
    surfaceVariant: AppColors.surfaceVariant, // #E6E3E0
    surfaceTint: Colors.transparent, // No tint
    background: AppColors.background, // #F7F6F4
    
    // Semantic colors
    error: AppColors.error,
    
    // On colors
    onPrimary: AppColors.white,
    onSecondary: AppColors.textPrimary,
    onSurface: AppColors.textPrimary, // #2E2B2B
    onBackground: AppColors.textPrimary,
    onError: AppColors.white,
    
    // Borders
    outline: AppColors.border, // #D7D3D0
    outlineVariant: AppColors.surfaceVariant,
  ),

  // Custom Theme Extension
  extensions: const <ThemeExtension<dynamic>>[
    AppThemeExtension.light,
  ],

  // Scaffold - Neutral Background
  scaffoldBackgroundColor: AppColors.background,

  // AppBar - Neutral
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: AppColors.iconNeutral),
    actionsIconTheme: IconThemeData(color: AppColors.iconNeutral),
  ),

  // Card - Neutral Surface
  cardTheme: CardThemeData(
    color: AppColors.surface,
    elevation: 2,
    shadowColor: AppColors.shadow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: AppColors.border.withOpacity(0.5),
        width: 1,
      ),
    ),
  ),

  // Elevated Button - REMOVED (use FilledButton instead)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryPeach,
      foregroundColor: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.primaryPeach.withOpacity(0.25),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  ),

  // Text Button - Neutral with peach accent on press
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryPeach,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),

  // Outlined Button - Neutral border, neutral text
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.textPrimary,
      side: const BorderSide(color: AppColors.border, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  ),

  // Filled Button - Peach accent (primary CTA)
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primaryPeach,
      foregroundColor: AppColors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  ),

  // Icon Button - Neutral icons, peach on active
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.iconNeutral,
    ),
  ),

  // Input Decoration - Neutral
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceVariant,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryPeach, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    hintStyle: TextStyle(color: AppColors.textSecondary),
    labelStyle: TextStyle(color: AppColors.textSecondary),
  ),

  // Divider - Neutral border
  dividerTheme: const DividerThemeData(
    color: AppColors.border,
    thickness: 1,
    space: 1,
  ),

  // Bottom Navigation Bar - Neutral surface, peach active
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primaryPeach,
    unselectedItemColor: AppColors.iconNeutral,
    elevation: 8,
    type: BottomNavigationBarType.fixed,
  ),

  // Icon Theme - Neutral icons
  iconTheme: const IconThemeData(
    color: AppColors.iconNeutral,
  ),

  // Primary Icon Theme - Peach for primary actions
  primaryIconTheme: const IconThemeData(
    color: AppColors.primaryPeach,
  ),

  // Tab Bar Theme - Neutral with peach active
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.textPrimary,
    unselectedLabelColor: AppColors.textSecondary,
    indicator: BoxDecoration(
      color: AppColors.primaryPeach,
      borderRadius: BorderRadius.circular(12),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  ),

  // Chip Theme - Neutral background, peach active
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceVariant,
    selectedColor: AppColors.primarySoft,
    labelStyle: const TextStyle(color: AppColors.textPrimary),
    secondaryLabelStyle: const TextStyle(color: AppColors.textPrimary),
    side: BorderSide(color: AppColors.border),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),

  // Switch Theme - Peach active
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.white;
      }
      return AppColors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryPeach;
      }
      return AppColors.border;
    }),
  ),

  // Progress Indicator - Peach
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryPeach,
    linearTrackColor: AppColors.surfaceVariant,
    circularTrackColor: AppColors.surfaceVariant,
  ),

  // Slider Theme - Peach
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primaryPeach,
    inactiveTrackColor: AppColors.surfaceVariant,
    thumbColor: AppColors.primaryPeach,
    overlayColor: AppColors.primaryPeach.withOpacity(0.12),
  ),

  // Text Theme - Neutral text
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
    bodySmall: TextStyle(color: AppColors.textSecondary),
    labelLarge: TextStyle(color: AppColors.textPrimary),
    labelMedium: TextStyle(color: AppColors.textSecondary),
    labelSmall: TextStyle(color: AppColors.textSecondary),
    titleLarge: TextStyle(color: AppColors.textPrimary),
    titleMedium: TextStyle(color: AppColors.textPrimary),
    titleSmall: TextStyle(color: AppColors.textPrimary),
    headlineLarge: TextStyle(color: AppColors.textPrimary),
    headlineMedium: TextStyle(color: AppColors.textPrimary),
    headlineSmall: TextStyle(color: AppColors.textPrimary),
  ).apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  ),
);
