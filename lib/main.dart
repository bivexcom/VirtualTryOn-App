import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'const/theme/light_theme.dart';
import 'const/theme/dark_theme.dart';
import 'core/utils/logger.dart';
import 'application/settings/bloc/theme_cubit.dart';

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

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const VirtualTryOnApp(),
    ),
  );
}

class VirtualTryOnApp extends StatelessWidget {
  const VirtualTryOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Virtual Try-On',

          // Theme Configuration with smooth animation
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          themeAnimationDuration: const Duration(milliseconds: 500),
          themeAnimationCurve: Curves.easeInOutCubic,

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
          routerConfig: appRouter.config(),
        );
      },
    );
  }
}
