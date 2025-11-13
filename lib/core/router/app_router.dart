import 'package:auto_route/auto_route.dart';
import '../../presentation/pages/onboarding/onboarding_screen.dart';
import '../../presentation/pages/try_on/try_on_screen.dart';
import '../../presentation/pages/gallery/gallery_screen.dart';
import '../../presentation/pages/profile/profile_screen.dart';
import '../../presentation/pages/settings/settings_screen.dart';
import '../../presentation/pages/result/result_screen.dart';
import '../navigation/main_navigation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // Onboarding
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
          initial: true,
        ),

        // Main Navigation with Bottom Tabs
        AutoRoute(
          page: MainNavigationRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: TryOnRoute.page,
              path: 'try-on',
            ),
            AutoRoute(
              page: GalleryRoute.page,
              path: 'gallery',
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
            ),
          ],
        ),

        // Other Routes
        AutoRoute(
          page: ResultRoute.page,
          path: '/result',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
        ),
      ];
}

