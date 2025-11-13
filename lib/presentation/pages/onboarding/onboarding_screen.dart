import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/router/app_router.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Hero Image Placeholder
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.checkroom,
                  size: 100,
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 48),
              // Title
              Text(
                context.l10n.onboarding_title,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                context.l10n.onboarding_subtitle,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Haptics.mediumImpact();
                    context.router.replace(const MainNavigationRoute());
                  },
                  child: Text(
                    context.l10n.onboarding_continue,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Terms and Privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Haptics.selection(),
                    child: Text(context.l10n.onboarding_terms),
                  ),
                  Text(
                    ' • ',
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Haptics.selection(),
                    child: Text(context.l10n.onboarding_privacy),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

