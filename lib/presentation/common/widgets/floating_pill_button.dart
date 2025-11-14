import 'package:flutter/material.dart';
import '../../../const/theme/app_colors.dart';
import '../../../core/utils/haptics.dart';

/// Premium floating pill button - compact, feminine, modern
/// Golden standard for fashion apps
/// Looks like a "magic trigger" not just a button
class FloatingPillButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const FloatingPillButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  State<FloatingPillButton> createState() => _FloatingPillButtonState();
}

class _FloatingPillButtonState extends State<FloatingPillButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Premium pastel gradient: Soft Rose Gold / Coral
  static const List<Color> _premiumGradient = [
    Color(0xFFF3D4C6), // Soft peach
    Color(0xFFE8A98F), // Coral
    Color(0xFFD4978A), // Rose gold
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      // Press down (70ms)
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.97,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      // Bounce up (140ms)
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.97,
          end: 1.02,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      // Settle down (140ms)
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.02,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onPressed != null && widget.isEnabled) {
      Haptics.lightImpact();
      _controller.forward(from: 0);
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 52,
          decoration: BoxDecoration(
            gradient: widget.isEnabled
                ? const LinearGradient(
                    colors: _premiumGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [AppColors.grey300, AppColors.grey400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              // 10% blur shadow with soft glow
              BoxShadow(
                color: widget.isEnabled
                    ? const Color(0xFFE8A98F).withOpacity(0.25)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: -2,
              ),
              // Additional ambient glow
              BoxShadow(
                color: widget.isEnabled
                    ? const Color(0xFFF3D4C6).withOpacity(0.2)
                    : Colors.transparent,
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -5,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sparkle icon with glow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
