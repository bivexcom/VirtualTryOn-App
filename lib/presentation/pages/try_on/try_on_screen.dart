import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/utils/haptics.dart';
import 'widgets/advanced_settings_section.dart';
import 'widgets/garment_item_slot.dart';
import 'widgets/gradient_button.dart';
import 'widgets/photo_upload_card.dart';

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
  File? _garmentImage1;
  File? _garmentImage2;

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

  Future<void> _pickImage(ImageSource source, String type) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          switch (type) {
            case 'user':
              _userPhoto = File(image.path);
              break;
            case 'garment1':
              _garmentImage1 = File(image.path);
              break;
            case 'garment2':
              _garmentImage2 = File(image.path);
              break;
          }
        });
        Haptics.lightImpact();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showImageSourceDialog(String type) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xFF1A1A22) : Colors.white,
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
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                ),
              ),
              const SizedBox(height: AppConstants.paddingLg),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(context.l10n.try_on_choose_gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, type);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(context.l10n.try_on_take_photo),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, type);
                },
              ),
              const SizedBox(height: AppConstants.paddingSm),
            ],
          ),
        ),
      ),
    );
  }

  void _removeImage(String type) {
    setState(() {
      switch (type) {
        case 'garment1':
          _garmentImage1 = null;
          break;
        case 'garment2':
          _garmentImage2 = null;
          break;
      }
    });
  }

  bool get _canGenerateOutfit =>
      _userPhoto != null && (_garmentImage1 != null || _garmentImage2 != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? const Color(0xFF0A0A0F)
          : const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.l10n.try_on_create_outfit,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMd,
              vertical: AppConstants.paddingSm,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? const Color(0xFF1A1A22)
                    : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF45C9F), Color(0xFF8B5CFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: context.isDarkMode
                    ? Colors.white.withOpacity(0.6)
                    : Colors.black.withOpacity(0.6),
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Photo Section
                Row(
                  children: [
                    Text(
                      context.l10n.try_on_model_photo,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CFF).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusFull,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.help_outline,
                            size: 16,
                            color: Color(0xFF8B5CFF),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            context.l10n.try_on_tips,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF8B5CFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingMd),
                PhotoUploadCard(
                  image: _userPhoto,
                  onImageSelected: () => _showImageSourceDialog('user'),
                  title: context.l10n.try_on_upload_your_photo,
                  subtitle: context.l10n.try_on_photo_subtitle,
                ),

                // Clothing & Accessories Section
                const SizedBox(height: AppConstants.paddingXl),
                Text(
                  context.l10n.try_on_clothing_accessories,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMd),
                Row(
                  children: [
                    Expanded(
                      child: GarmentItemSlot(
                        image: _garmentImage1,
                        onTap: () {
                          if (_garmentImage1 == null) {
                            _showImageSourceDialog('garment1');
                          } else {
                            _removeImage('garment1');
                          }
                        },
                        label: context.l10n.try_on_add_item,
                      ),
                    ),
                    const SizedBox(width: AppConstants.paddingMd),
                    Expanded(
                      child: GarmentItemSlot(
                        image: _garmentImage2,
                        onTap: () {
                          if (_garmentImage2 == null) {
                            _showImageSourceDialog('garment2');
                          } else {
                            _removeImage('garment2');
                          }
                        },
                        label: context.l10n.try_on_add_item,
                      ),
                    ),
                  ],
                ),

                // Advanced Settings Section
                const SizedBox(height: AppConstants.paddingXl),
                const AdvancedSettingsSection(),

                const SizedBox(height: 120), // Space for button
              ],
            ),
          ),
        ),

        // Bottom Gradient Button
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: context.isDarkMode
                  ? [
                      const Color(0xFF0A0A0F).withOpacity(0),
                      const Color(0xFF0A0A0F),
                    ]
                  : [Colors.white.withOpacity(0), Colors.white],
            ),
          ),
          padding: EdgeInsets.only(
            left: AppConstants.paddingMd,
            right: AppConstants.paddingMd,
            bottom:
                MediaQuery.of(context).padding.bottom + AppConstants.paddingMd,
            top: AppConstants.paddingLg,
          ),
          child: GradientButton(
            onPressed: _canGenerateOutfit
                ? () {
                    // TODO: Navigate to processing/result
                    debugPrint('Generating outfit...');
                  }
                : null,
            label: context.l10n.try_on_generate,
            icon: Icons.auto_awesome,
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogTab(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shop, size: 64, color: context.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            context.l10n.try_on_catalog,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Browse branded items',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
