/// App-wide constants
class AppConstants {
  AppConstants._();

  // Padding - Premium Apple-style spacing
  static const double paddingXs = 4.0;
  static const double paddingSm = 12.0; // 8 → 12
  static const double paddingMd = 24.0; // 16 → 24
  static const double paddingLg = 32.0; // 24 → 32
  static const double paddingXl = 40.0; // 32 → 40
  static const double paddingXxl = 48.0; // 40 → 48

  // Border Radius
  static const double radiusXs = 8.0;
  static const double radiusSm = 12.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 24.0;
  static const double radiusXxl = 28.0;
  static const double radiusFull = 999.0;

  // Animation Durations (milliseconds)
  static const int durationFast = 200;
  static const int durationNormal = 300;
  static const int durationSlow = 500;

  // Shadow
  static const double shadowBlurLight = 15.0;
  static const double shadowBlurMedium = 20.0;
  static const double shadowBlurHeavy = 25.0;

  // API
  static const int maxGarmentImages = 2;
  static const String apiBaseUrl = 'https://api.example.com'; // TODO: Update with actual API URL
  
  // Storage Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingComplete = 'onboarding_complete';
}

