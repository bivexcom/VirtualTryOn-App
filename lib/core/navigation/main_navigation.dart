import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/utils/haptics.dart';
import '../../presentation/common/widgets/app_bottom_nav_bar.dart';
import '../router/app_router.dart';

@RoutePage()
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    Haptics.selection();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [TryOnRoute(), GalleryRoute(), ProfileRoute()],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: _fadeAnimation, child: child);
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: AppBottomNavBar(
            tabsRouter: tabsRouter,
            onTabChanged: _onTabChanged,
          ),
        );
      },
    );
  }
}
