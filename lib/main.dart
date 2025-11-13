import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'const/theme/light_theme.dart';
import 'const/theme/dark_theme.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Initialize dependency injection
  await configureDependencies();

  Logger.success('App initialized successfully', tag: 'Main');

  runApp(const VirtualTryOnApp());
}

class VirtualTryOnApp extends StatefulWidget {
  const VirtualTryOnApp({super.key});

  @override
  State<VirtualTryOnApp> createState() => _VirtualTryOnAppState();
}

class _VirtualTryOnAppState extends State<VirtualTryOnApp> {
  final _appRouter = AppRouter();
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Try-On',

      // Theme Configuration
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,

      // Localization Configuration
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('tr'), // Turkish
        Locale('de'), // German
        Locale('fr'), // French
        Locale('es'), // Spanish
        Locale('it'), // Italian
        Locale('pt'), // Portuguese
        Locale('ru'), // Russian
        Locale('nl'), // Dutch
      ],

      // Router Configuration
      routerConfig: _appRouter.config(),
    );
  }
}
