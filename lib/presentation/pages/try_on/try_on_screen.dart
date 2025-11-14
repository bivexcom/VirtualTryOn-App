import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/utils/haptics.dart';
import '../../../const/theme/theme_extensions.dart';
import '../../common/widgets/floating_pill_button.dart';
import 'widgets/outfit_item_slot.dart';
import 'widgets/photo_upload_card.dart';

// Enums for Wiro API integration
enum PhotographyStyle {
  virtualTryOn, // "virtual-try-on"
  studio, // "studio"
  indoor, // "indoor"
  outdoor, // "outdoor"
}

enum OutputType {
  both, // "both"
  image, // "image"
  video, // "video"
}

class OutfitItem {
  final File? image;
  final String? category;

  OutfitItem({this.image, this.category});

  OutfitItem copyWith({File? image, String? category}) {
    return OutfitItem(
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }
}

@RoutePage()
class TryOnScreen extends StatefulWidget {
  const TryOnScreen({super.key});

  @override
  State<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends State<TryOnScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();

  File? _userPhoto;
  OutfitItem _outfitItem1 = OutfitItem();
  OutfitItem _outfitItem2 = OutfitItem();
  int? _selectedSlotForPicker; // 1 or 2

  // Session settings
  PhotographyStyle _photographyStyle = PhotographyStyle.virtualTryOn;
  OutputType _outputType = OutputType.both;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        Haptics.selection();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(
    ImageSource source, {
    bool isOutfitSlot = false,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          if (isOutfitSlot && _selectedSlotForPicker != null) {
            if (_selectedSlotForPicker == 1) {
              _outfitItem1 = _outfitItem1.copyWith(image: File(image.path));
            } else if (_selectedSlotForPicker == 2) {
              _outfitItem2 = _outfitItem2.copyWith(image: File(image.path));
            }
            _selectedSlotForPicker = null;
          } else {
            _userPhoto = File(image.path);
          }
        });
        Haptics.lightImpact();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showImageSourceDialog({bool isOutfitSlot = false}) {
    final colors = context.appColors;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusXl),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppConstants.paddingSm),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
              ),
              const SizedBox(height: AppConstants.paddingMd),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(context.l10n.try_on_choose_gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, isOutfitSlot: isOutfitSlot);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(context.l10n.try_on_take_photo),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, isOutfitSlot: isOutfitSlot);
                },
              ),
              const SizedBox(height: AppConstants.paddingSm),
            ],
          ),
        ),
      ),
    );
  }

  void _onOutfitSlotTapped(int slotNumber) {
    setState(() {
      _selectedSlotForPicker = slotNumber;
    });
    _showImageSourceDialog(isOutfitSlot: true);
  }

  void _onRemoveOutfitItem(int slotNumber) {
    setState(() {
      if (slotNumber == 1) {
        _outfitItem1 = OutfitItem();
      } else if (slotNumber == 2) {
        _outfitItem2 = OutfitItem();
      }
    });
  }

  int get _outfitItemsCount {
    int count = 0;
    if (_outfitItem1.image != null) count++;
    if (_outfitItem2.image != null) count++;
    return count;
  }

  bool get _canGenerateOutfit => _userPhoto != null && _outfitItemsCount > 0;

  // Map enums to Wiro API strings
  String _mapPhotographyStyle(PhotographyStyle style) {
    switch (style) {
      case PhotographyStyle.virtualTryOn:
        return "virtual-try-on";
      case PhotographyStyle.studio:
        return "studio";
      case PhotographyStyle.indoor:
        return "indoor";
      case PhotographyStyle.outdoor:
        return "outdoor";
    }
  }

  String _mapOutputType(OutputType type) {
    switch (type) {
      case OutputType.both:
        return "both";
      case OutputType.image:
        return "image";
      case OutputType.video:
        return "video";
    }
  }

  // Get display text for enums
  String _getPhotographyStyleSubtitle(PhotographyStyle style) {
    switch (style) {
      case PhotographyStyle.virtualTryOn:
        return "Keep Original Scene";
      case PhotographyStyle.studio:
        return "Professional Setup";
      case PhotographyStyle.indoor:
        return "Natural Indoor Light";
      case PhotographyStyle.outdoor:
        return "Outdoor Environment";
    }
  }

  // Get image asset path for photography style
  String _getPhotographyStyleImage(PhotographyStyle style) {
    switch (style) {
      case PhotographyStyle.virtualTryOn:
        return 'assets/images/virtual-try-on.jpg';
      case PhotographyStyle.studio:
        return 'assets/images/studio-photography.jpg';
      case PhotographyStyle.indoor:
        return 'assets/images/indoor-lifestyle.jpg';
      case PhotographyStyle.outdoor:
        return 'assets/images/outdoor-lifestyle.jpg';
    }
  }

  String _getPhotographyStyleShortLabel(PhotographyStyle style) {
    switch (style) {
      case PhotographyStyle.virtualTryOn:
        return 'Virtual';
      case PhotographyStyle.studio:
        return 'Studio';
      case PhotographyStyle.indoor:
        return 'Indoor';
      case PhotographyStyle.outdoor:
        return 'Outdoor';
    }
  }

  // Build photography style visual card
  Widget _buildPhotographyStyleCard(
    BuildContext context,
    PhotographyStyle style,
  ) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _photographyStyle == style;

    return _PhotographyStyleCard(
      style: style,
      isSelected: isSelected,
      colors: colors,
      isDark: isDark,
      onTap: () {
        Haptics.selection();
        setState(() {
          _photographyStyle = style;
        });
      },
      getImage: _getPhotographyStyleImage,
      getLabel: _getPhotographyStyleShortLabel,
      getSubtitle: _getPhotographyStyleSubtitle,
    );
  }

  // Build output type segmented control
  Widget _buildOutputTypeSegmentedControl(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.5),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.white.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                children: [
                  _OutputTypeSegment(
                    type: OutputType.both,
                    label: 'Both',
                    icon: Icons.collections_outlined,
                    isSelected: _outputType == OutputType.both,
                    onTap: () {
                      Haptics.selection();
                      setState(() {
                        _outputType = OutputType.both;
                      });
                    },
                  ),
                  _OutputTypeSegment(
                    type: OutputType.image,
                    label: 'Image',
                    icon: Icons.image_outlined,
                    isSelected: _outputType == OutputType.image,
                    onTap: () {
                      Haptics.selection();
                      setState(() {
                        _outputType = OutputType.image;
                      });
                    },
                  ),
                  _OutputTypeSegment(
                    type: OutputType.video,
                    label: 'Video',
                    icon: Icons.play_circle_outline,
                    isSelected: _outputType == OutputType.video,
                    onTap: () {
                      Haptics.selection();
                      setState(() {
                        _outputType = OutputType.video;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? colors.background : const Color(0xFFF6F5F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(26),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark
                    ? colors.surfaceVariant.withOpacity(0.5)
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : const Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primarySoft,
                      colors.primaryPeach.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primaryPeach.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: isDark
                    ? colors.primaryDark
                    : const Color(0xFF2D2A28),
                unselectedLabelColor: isDark
                    ? colors.textSecondary
                    : const Color(0xFF8E8580),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: -0.2,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: -0.2,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: context.l10n.try_on_custom),
                  Tab(text: context.l10n.try_on_catalog),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCustomTab(context), _buildCatalogTab(context)],
      ),
    );
  }

  Widget _buildCustomTab(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Main content
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Photo Section with Tips
              Row(
                children: [
                  Text(
                    'Model Photo',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: -0.5,
                      color: isDark
                          ? colors.textPrimary
                          : const Color(0xFF2D2A28),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryPeach.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 14,
                          color: colors.primaryPeach,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          context.l10n.try_on_tips,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.primaryPeach,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PhotoUploadCard(
                image: _userPhoto,
                onImageSelected: () => _showImageSourceDialog(),
                title: context.l10n.try_on_upload_your_photo,
                subtitle: context.l10n.try_on_photo_subtitle,
              ),

              // Outfit Items Section - Grouped in a subtle container
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.03)
                      : const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and count
                    Row(
                      children: [
                        Text(
                          'Outfit Items',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: -0.5,
                            color: isDark
                                ? colors.textPrimary
                                : const Color(0xFF2D2A28),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$_outfitItemsCount / 2',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? colors.textSecondary
                                  : const Color(0xFF8E8580),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Two Glass Item Slots
                    Row(
                      children: [
                        Expanded(
                          child: OutfitItemSlot(
                            image: _outfitItem1.image,
                            category: _outfitItem1.category,
                            slotLabel: 'Item 1',
                            onTap: () => _onOutfitSlotTapped(1),
                            onRemove: _outfitItem1.image != null
                                ? () => _onRemoveOutfitItem(1)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutfitItemSlot(
                            image: _outfitItem2.image,
                            category: _outfitItem2.category,
                            slotLabel: 'Item 2',
                            onTap: () => _onOutfitSlotTapped(2),
                            onRemove: _outfitItem2.image != null
                                ? () => _onRemoveOutfitItem(2)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Session Settings Section - Grouped in a subtle container
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.03)
                      : const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photography Style - Horizontal visual selector
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Photography Style',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: isDark
                                  ? colors.textPrimary
                                  : const Color(0xFF2D2A28),
                            ),
                          ),
                          Text(
                            _getPhotographyStyleShortLabel(_photographyStyle),
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          itemCount: PhotographyStyle.values.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return _buildPhotographyStyleCard(
                              context,
                              PhotographyStyle.values[index],
                            );
                          },
                        ),
                      ),
                    ),

                    // Output Type - Segmented control
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Output Type',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isDark
                              ? colors.textPrimary
                              : const Color(0xFF2D2A28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 20,
                      ),
                      child: _buildOutputTypeSegmentedControl(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),

        // Floating Premium Pill Button
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: SafeArea(
            child: Center(
              child: FloatingPillButton(
                text: context.l10n.try_on_generate,
                icon: Icons.auto_awesome,
                isEnabled: _canGenerateOutfit,
                onPressed: _canGenerateOutfit
                    ? () {
                        // TODO: Navigate to processing/result
                        final styleParam = _mapPhotographyStyle(
                          _photographyStyle,
                        );
                        final outputTypeParam = _mapOutputType(_outputType);

                        debugPrint('Generating outfit...');
                        debugPrint('Style: $styleParam');
                        debugPrint('Output Type: $outputTypeParam');
                        debugPrint('User Photo: ${_userPhoto?.path}');
                        debugPrint(
                          'Outfit Item 1: ${_outfitItem1.image?.path}',
                        );
                        debugPrint(
                          'Outfit Item 2: ${_outfitItem2.image?.path}',
                        );

                        // Example payload structure for backend/Wiro:
                        // final payload = {
                        //   "humanImage": _userPhoto,
                        //   "clothes": [
                        //     if (_outfitItem1.image != null) _outfitItem1.image,
                        //     if (_outfitItem2.image != null) _outfitItem2.image,
                        //   ],
                        //   "style": styleParam,
                        //   "pose": "auto",
                        //   "plan": "auto",
                        //   "outputType": outputTypeParam,
                        // };
                      }
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogTab(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colors.primarySoft.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shop_outlined,
              size: 40,
              color: colors.primaryPeach,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Coming Soon',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: -0.5,
              color: isDark ? colors.textPrimary : const Color(0xFF2D2A28),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Browse premium branded items from top fashion retailers',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? colors.textSecondary.withOpacity(0.7)
                    : const Color(0xFF8E8580),
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Output Type Segment with smooth animations
class _OutputTypeSegment extends StatefulWidget {
  final OutputType type;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OutputTypeSegment({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_OutputTypeSegment> createState() => _OutputTypeSegmentState();
}

class _OutputTypeSegmentState extends State<_OutputTypeSegment>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: widget.isSelected
                      ? LinearGradient(
                          colors: [
                            colors.primarySoft,
                            colors.primaryPeach.withOpacity(0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: widget.isSelected
                      ? [
                          BoxShadow(
                            color: colors.primaryPeach.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    scale: widget.isSelected ? 1.0 : 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            widget.icon,
                            key: ValueKey(widget.isSelected),
                            size: widget.isSelected ? 17 : 15,
                            color: widget.isSelected
                                ? (isDark
                                      ? colors.primaryDark
                                      : const Color(0xFF2D2A28))
                                : colors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 5),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: widget.isSelected ? 13.5 : 13,
                            letterSpacing: -0.2,
                            color: widget.isSelected
                                ? (isDark
                                      ? colors.primaryDark
                                      : const Color(0xFF2D2A28))
                                : colors.textSecondary,
                          ),
                          child: Text(widget.label),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Photography Style Card with smooth animations
class _PhotographyStyleCard extends StatefulWidget {
  final PhotographyStyle style;
  final bool isSelected;
  final dynamic colors;
  final bool isDark;
  final VoidCallback onTap;
  final String Function(PhotographyStyle) getImage;
  final String Function(PhotographyStyle) getLabel;
  final String Function(PhotographyStyle) getSubtitle;

  const _PhotographyStyleCard({
    required this.style,
    required this.isSelected,
    required this.colors,
    required this.isDark,
    required this.onTap,
    required this.getImage,
    required this.getLabel,
    required this.getSubtitle,
  });

  @override
  State<_PhotographyStyleCard> createState() => _PhotographyStyleCardState();
}

class _PhotographyStyleCardState extends State<_PhotographyStyleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _brightnessAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _brightnessAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 160,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        ? widget.colors.primaryPeach.withOpacity(0.25)
                        : Colors.black.withOpacity(widget.isDark ? 0.2 : 0.04),
                    blurRadius: widget.isSelected ? 20 : 18,
                    spreadRadius: widget.isSelected ? 2 : 0,
                    offset: Offset(0, widget.isSelected ? 6 : 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background image
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(
                          1 - _brightnessAnimation.value,
                        ),
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        widget.getImage(widget.style),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.45),
                          ],
                        ),
                      ),
                    ),
                    // Animated border for selected state
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.isSelected
                              ? Colors.white.withOpacity(0.9)
                              : Colors.transparent,
                          width: widget.isSelected ? 2.5 : 0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // Subtle highlight overlay when selected
                    if (widget.isSelected)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.colors.primaryPeach.withOpacity(0.08),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: widget.isSelected ? 16 : 15,
                              color: Colors.white,
                              letterSpacing: -0.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(widget.getLabel(widget.style)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.getSubtitle(widget.style),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.85),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Animated check icon for selected
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      top: widget.isSelected ? 8 : -30,
                      right: 8,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: widget.isSelected ? 1.0 : 0.0,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.colors.primaryPeach.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: widget.colors.primaryPeach,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
