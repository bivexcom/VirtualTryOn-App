import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/router/app_router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile_title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Settings Tile
          _buildTile(
            context: context,
            icon: Icons.settings,
            title: context.l10n.profile_settings,
            onTap: () {
              Haptics.selection();
              context.router.push(const SettingsRoute());
            },
          ),
          const SizedBox(height: 8),

          // Language Tile
          _buildTile(
            context: context,
            icon: Icons.language,
            title: context.l10n.profile_language,
            trailing: const Text('English'),
            onTap: () {
              Haptics.selection();
              // TODO: Show language picker
            },
          ),
          const SizedBox(height: 8),

          // Theme Tile
          _buildTile(
            context: context,
            icon: Icons.palette,
            title: context.l10n.profile_theme,
            trailing: Text(context.l10n.profile_theme_system),
            onTap: () {
              Haptics.selection();
              // TODO: Show theme picker
            },
          ),
          const SizedBox(height: 24),

          // About Section
          _buildTile(
            context: context,
            icon: Icons.info_outline,
            title: context.l10n.profile_about,
            onTap: () {
              Haptics.selection();
            },
          ),
          const SizedBox(height: 8),

          // Version
          _buildTile(
            context: context,
            icon: Icons.tag,
            title: context.l10n.profile_version,
            trailing: const Text('1.0.0'),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: context.colorScheme.primary),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

