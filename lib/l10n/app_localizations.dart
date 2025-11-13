import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Virtual Try-On'**
  String get app_name;

  /// No description provided for @onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Transform Your Style'**
  String get onboarding_title;

  /// No description provided for @onboarding_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Try on any outfit with AI magic'**
  String get onboarding_subtitle;

  /// No description provided for @onboarding_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboarding_continue;

  /// No description provided for @onboarding_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get onboarding_terms;

  /// No description provided for @onboarding_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onboarding_privacy;

  /// No description provided for @tab_try_on.
  ///
  /// In en, this message translates to:
  /// **'Try On'**
  String get tab_try_on;

  /// No description provided for @tab_gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get tab_gallery;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;

  /// No description provided for @try_on_title.
  ///
  /// In en, this message translates to:
  /// **'Virtual Try-On'**
  String get try_on_title;

  /// No description provided for @try_on_create_outfit.
  ///
  /// In en, this message translates to:
  /// **'Create Your Outfit'**
  String get try_on_create_outfit;

  /// No description provided for @try_on_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get try_on_custom;

  /// No description provided for @try_on_catalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get try_on_catalog;

  /// No description provided for @try_on_select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get try_on_select_gender;

  /// No description provided for @try_on_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get try_on_male;

  /// No description provided for @try_on_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get try_on_female;

  /// No description provided for @try_on_upload_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get try_on_upload_photo;

  /// No description provided for @try_on_upload_your_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Photo'**
  String get try_on_upload_your_photo;

  /// No description provided for @try_on_photo_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a clear, full-body photo for best results.'**
  String get try_on_photo_subtitle;

  /// No description provided for @try_on_model_photo.
  ///
  /// In en, this message translates to:
  /// **'Your Model Photo'**
  String get try_on_model_photo;

  /// No description provided for @try_on_tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get try_on_tips;

  /// No description provided for @try_on_choose_file.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get try_on_choose_file;

  /// No description provided for @try_on_select_garment.
  ///
  /// In en, this message translates to:
  /// **'Select Garment'**
  String get try_on_select_garment;

  /// No description provided for @try_on_clothing_accessories.
  ///
  /// In en, this message translates to:
  /// **'Clothing & Accessories'**
  String get try_on_clothing_accessories;

  /// No description provided for @try_on_add_item.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get try_on_add_item;

  /// No description provided for @try_on_advanced_settings.
  ///
  /// In en, this message translates to:
  /// **'Advanced Settings'**
  String get try_on_advanced_settings;

  /// No description provided for @try_on_photography_style.
  ///
  /// In en, this message translates to:
  /// **'Photography Style'**
  String get try_on_photography_style;

  /// No description provided for @try_on_quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get try_on_quality;

  /// No description provided for @try_on_style_studio.
  ///
  /// In en, this message translates to:
  /// **'Studio'**
  String get try_on_style_studio;

  /// No description provided for @try_on_style_outdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get try_on_style_outdoor;

  /// No description provided for @try_on_style_casual.
  ///
  /// In en, this message translates to:
  /// **'Casual'**
  String get try_on_style_casual;

  /// No description provided for @try_on_style_professional.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get try_on_style_professional;

  /// No description provided for @try_on_quality_standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get try_on_quality_standard;

  /// No description provided for @try_on_quality_hd.
  ///
  /// In en, this message translates to:
  /// **'HD'**
  String get try_on_quality_hd;

  /// No description provided for @try_on_generate.
  ///
  /// In en, this message translates to:
  /// **'Generate Outfit'**
  String get try_on_generate;

  /// No description provided for @try_on_choose_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get try_on_choose_gallery;

  /// No description provided for @try_on_take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get try_on_take_photo;

  /// No description provided for @try_on_max_items.
  ///
  /// In en, this message translates to:
  /// **'Max 2 items'**
  String get try_on_max_items;

  /// No description provided for @processing_title.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing_title;

  /// No description provided for @processing_percentage.
  ///
  /// In en, this message translates to:
  /// **'{percentage}%'**
  String processing_percentage(int percentage);

  /// No description provided for @result_title.
  ///
  /// In en, this message translates to:
  /// **'Your outfit is ready ✨'**
  String get result_title;

  /// No description provided for @result_download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get result_download;

  /// No description provided for @result_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get result_share;

  /// No description provided for @result_try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get result_try_again;

  /// No description provided for @result_brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get result_brand;

  /// No description provided for @result_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get result_category;

  /// No description provided for @result_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get result_date;

  /// No description provided for @gallery_title.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery_title;

  /// No description provided for @gallery_empty.
  ///
  /// In en, this message translates to:
  /// **'No looks yet'**
  String get gallery_empty;

  /// No description provided for @gallery_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Start creating your virtual outfits'**
  String get gallery_empty_subtitle;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profile_settings;

  /// No description provided for @profile_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_language;

  /// No description provided for @profile_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profile_theme;

  /// No description provided for @profile_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profile_theme_light;

  /// No description provided for @profile_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profile_theme_dark;

  /// No description provided for @profile_theme_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profile_theme_system;

  /// No description provided for @profile_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profile_about;

  /// No description provided for @profile_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get profile_version;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settings_general;

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settings_privacy;

  /// No description provided for @settings_support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settings_support;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_generic;

  /// No description provided for @error_network.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get error_network;

  /// No description provided for @error_try_again.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get error_try_again;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get button_confirm;

  /// No description provided for @button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get button_save;

  /// No description provided for @button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get button_delete;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pt',
    'ru',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
