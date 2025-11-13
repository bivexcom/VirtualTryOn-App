import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/haptics.dart';

class PhotoUploadCard extends StatelessWidget {
  final File? image;
  final VoidCallback onImageSelected;
  final String title;
  final String subtitle;

  const PhotoUploadCard({
    super.key,
    required this.image,
    required this.onImageSelected,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A22) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
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
          : _buildUploadPrompt(context),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusXl - 2),
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
                onImageSelected();
              },
              borderRadius: BorderRadius.circular(AppConstants.radiusFull),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    final isDark = context.isDarkMode;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Haptics.lightImpact();
          onImageSelected();
        },
        borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF45C9F), Color(0xFF8B5CFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF45C9F).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
                child: Text(
                  context.l10n.try_on_choose_file,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFF45C9F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

