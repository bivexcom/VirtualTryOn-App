import 'dart:io';
import 'package:flutter/material.dart';
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
    final isDark = context.isDarkMode;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: AppConstants.durationNormal),
          height: 160,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A22) : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF2A2A35)
                  : const Color(0xFFE0E0E0),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: image != null
              ? _buildImagePreview(context)
              : _buildAddButton(context),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? Colors.white.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),
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
          top: 8,
          right: 8,
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
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final isDark = context.isDarkMode;

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
                  color: isDark
                      ? const Color(0xFF2A2A35)
                      : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Icon(
                  Icons.add,
                  color: isDark ? Colors.white : Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

