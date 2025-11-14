import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../const/theme/app_colors.dart';
import '../../../core/extensions/build_context_extensions.dart';

/// Modern, premium bottom navigation bar that stays visually lighter
/// than the floating Generate button.
///
/// Features:
/// - Subtle background with low opacity
/// - Clean, flat design without pill shapes
/// - Smooth animations for tab transitions
/// - Theme-aware (light/dark mode support)
/// - Selected tab: larger icon, visible label, indicator
/// - Unselected tabs: icon only with low opacity
class AppBottomNavBar extends StatelessWidget {
  final TabsRouter tabsRouter;
  final void Function(int index) onTabChanged;

  const AppBottomNavBar({
    super.key,
    required this.tabsRouter,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Use the app's background color
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.background;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark
                ? colorScheme.onSurface.withOpacity(0.1)
                : colorScheme.onSurface.withOpacity(0.08),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavItem(
                iconAsset: 'assets/images/clothes-hanger.png',
                label: context.l10n.tab_try_on,
                isSelected: tabsRouter.activeIndex == 0,
                onTap: () {
                  onTabChanged(0);
                  tabsRouter.setActiveIndex(0);
                },
              ),
              _NavItem(
                iconAsset: 'assets/images/gallery.png',
                label: context.l10n.tab_gallery,
                isSelected: tabsRouter.activeIndex == 1,
                onTap: () {
                  onTabChanged(1);
                  tabsRouter.setActiveIndex(1);
                },
              ),
              _NavItem(
                iconAsset: 'assets/images/user.png',
                label: context.l10n.tab_profile,
                isSelected: tabsRouter.activeIndex == 2,
                onTap: () {
                  onTabChanged(2);
                  tabsRouter.setActiveIndex(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual navigation item - simple and flat like in the design
class _NavItem extends StatelessWidget {
  final String iconAsset;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconAsset,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Colors based on selection state and theme
    final Color iconColor;
    final Color labelColor;

    if (isSelected) {
      // Active: different colors for light vs dark theme
      if (isDark) {
        // Dark theme: white/light color
        iconColor = colorScheme.onSurface;
        labelColor = colorScheme.onSurface;
      } else {
        // Light theme: primary peach color
        iconColor = colorScheme.onSurface;
        labelColor = colorScheme.onSurface;
      }
    } else {
      // Inactive: subtle gray with lower opacity
      if (isDark) {
        iconColor = colorScheme.onSurface.withOpacity(0.4);
        labelColor = colorScheme.onSurface.withOpacity(0.4);
      } else {
        iconColor = colorScheme.onSurface.withOpacity(0.35);
        labelColor = colorScheme.onSurface.withOpacity(0.35);
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: (isDark ? colorScheme.onSurface : colorScheme.primary)
            .withOpacity(0.1),
        highlightColor: (isDark ? colorScheme.onSurface : colorScheme.primary)
            .withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              // Icon - PNG asset with color filter
              ColorFiltered(
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                child: Image.asset(
                  iconAsset,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 2),

              // Label - always visible
              Text(
                label,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: labelColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  height: 1.0,
                  letterSpacing: 0.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
