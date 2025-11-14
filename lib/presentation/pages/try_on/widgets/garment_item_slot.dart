import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../const/theme/theme_extensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/haptics.dart';

class GarmentItemSlot extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final String label;

  const GarmentItemSlot({
    super.key,
    required this.image,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: AppConstants.durationNormal),
          height: 160,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(
              color: colors.border,
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: image != null
              ? _buildImagePreview(context)
              : _buildAddButton(context),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg - 2),
          child: Image.file(
            image!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Material(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(AppConstants.radiusFull),
            child: InkWell(
              onTap: () {
                Haptics.lightImpact();
                onTap();
              },
              borderRadius: BorderRadius.circular(AppConstants.radiusFull),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Haptics.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Icon(Icons.add, color: colors.textPrimary, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
