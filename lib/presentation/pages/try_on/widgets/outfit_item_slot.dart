import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../const/theme/theme_extensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/haptics.dart';

class OutfitItemSlot extends StatefulWidget {
  final File? image;
  final String? category;
  final String slotLabel;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const OutfitItemSlot({
    super.key,
    this.image,
    this.category,
    required this.slotLabel,
    required this.onTap,
    this.onRemove,
  });

  @override
  State<OutfitItemSlot> createState() => _OutfitItemSlotState();
}

class _OutfitItemSlotState extends State<OutfitItemSlot> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEmpty = widget.image == null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        Haptics.lightImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? colors.primaryPeach.withOpacity(0.15)
                    : Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                blurRadius: _isPressed ? 16 : 20,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.white.withOpacity(0.7),
                  border: Border.all(
                    color: _isPressed
                        ? colors.primaryPeach.withOpacity(0.4)
                        : isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.white.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: isEmpty
                    ? _buildEmptyState(context, colors, isDark)
                    : _buildFilledState(context, colors, isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, colors, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : colors.primarySoft.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                'assets/images/clothes.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Label
          Text(
            'Add item',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: -0.2,
              color: isDark
                  ? Colors.white.withOpacity(0.9)
                  : colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilledState(BuildContext context, colors, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.file(widget.image!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.category ?? widget.slotLabel,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: -0.2,
                    color: isDark
                        ? Colors.white.withOpacity(0.95)
                        : colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tap to manage',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : colors.textSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Remove button
          GestureDetector(
            onTap: () {
              Haptics.lightImpact();
              widget.onRemove?.call();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 18,
                color: isDark
                    ? Colors.white.withOpacity(0.7)
                    : colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
