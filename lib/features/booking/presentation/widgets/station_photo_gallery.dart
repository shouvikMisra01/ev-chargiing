import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Photo gallery carousel for charging station images
///
/// Features:
/// - Swipeable carousel with indicators
/// - Tap to open full-screen zoomable view
/// - Glass effect on indicators
/// - Placeholder for no images
class StationPhotoGallery extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final double borderRadius;

  const StationPhotoGallery({
    super.key,
    required this.imageUrls,
    this.height = 200,
    this.borderRadius = GlassTheme.radiusLarge,
  });

  @override
  State<StationPhotoGallery> createState() => _StationPhotoGalleryState();
}

class _StationPhotoGalleryState extends State<StationPhotoGallery> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return _buildPlaceholder();
    }

    return Stack(
      children: [
        _buildCarousel(),
        _buildPageIndicators(),
        _buildFullScreenButton(),
      ],
    );
  }

  Widget _buildCarousel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return _buildImage(widget.imageUrls[index]);
          },
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => Container(
          color: AppColors.surface,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.surface,
          child: const Center(
            child: Icon(
              Icons.broken_image,
              size: 48,
              color: AppColors.textHint,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    if (widget.imageUrls.length <= 1) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 12,
      left: 0,
      right: 0,
      child: Center(
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          borderRadius: 16,
          enableBlur: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.imageUrls.length,
              (index) => _buildIndicator(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final isActive = index == _currentIndex;

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: isActive ? 20 : 6,
        height: 6,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.textHint,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildFullScreenButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: GlassCard(
        padding: const EdgeInsets.all(8),
        borderRadius: GlassTheme.radiusMedium,
        enableBlur: true,
        onTap: () => _openFullScreen(context),
        child: const Icon(
          Icons.fullscreen,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        gradient: GlassTheme.primaryGradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.ev_station,
              size: 48,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              'No photos available',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenGallery(
          imageUrls: widget.imageUrls,
          initialIndex: _currentIndex,
        ),
      ),
    );
  }
}

/// Full-screen zoomable photo gallery
class FullScreenGallery extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  widget.imageUrls[index],
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.imageUrls[index],
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),

          // Close button
          SafeArea(
            child: Positioned(
              top: 16,
              left: 16,
              child: GlassCard(
                padding: const EdgeInsets.all(8),
                borderRadius: GlassTheme.radiusMedium,
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

          // Counter
          if (widget.imageUrls.length > 1)
            SafeArea(
              child: Positioned(
                top: 16,
                right: 16,
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  borderRadius: GlassTheme.radiusMedium,
                  child: Text(
                    '${_currentIndex + 1} / ${widget.imageUrls.length}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
