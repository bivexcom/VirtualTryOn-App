import 'package:flutter/material.dart';
import '../../../../const/theme/theme_extensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/haptics.dart';

class AdvancedSettingsSection extends StatefulWidget {
  const AdvancedSettingsSection({super.key});

  @override
  State<AdvancedSettingsSection> createState() =>
      _AdvancedSettingsSectionState();
}

class _AdvancedSettingsSectionState extends State<AdvancedSettingsSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.durationNormal),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    Haptics.selection();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: AppConstants.durationNormal),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMd,
                vertical: AppConstants.paddingMd,
              ),
              child: Row(
                children: [
                  Text(
                    context.l10n.try_on_advanced_settings,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildSettingsContent(context),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: AppConstants.durationNormal),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: colors.border, height: 1),
          const SizedBox(height: AppConstants.paddingMd),
          Text(
            context.l10n.try_on_photography_style,
            style: context.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStyleChip(context, context.l10n.try_on_style_studio, true),
              _buildStyleChip(
                context,
                context.l10n.try_on_style_outdoor,
                false,
              ),
              _buildStyleChip(context, context.l10n.try_on_style_casual, false),
              _buildStyleChip(
                context,
                context.l10n.try_on_style_professional,
                false,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMd),
          Text(
            context.l10n.try_on_quality,
            style: context.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildQualityChip(
                context,
                context.l10n.try_on_quality_standard,
                false,
              ),
              const SizedBox(width: 8),
              _buildQualityChip(context, context.l10n.try_on_quality_hd, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyleChip(BuildContext context, String label, bool isSelected) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primaryPeach.withOpacity(0.15)
            : colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
        border: isSelected
            ? Border.all(color: colors.primaryPeach, width: 1.5)
            : null,
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: isSelected ? colors.primaryPeach : colors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildQualityChip(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    final colors = context.appColors;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryPeach.withOpacity(0.15)
              : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          border: isSelected
              ? Border.all(color: colors.primaryPeach, width: 1.5)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: isSelected ? colors.primaryPeach : colors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
