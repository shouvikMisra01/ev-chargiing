import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/glass_button.dart';
import '../../../owner/domain/entities/provider_entity.dart';
import 'provider_list_item.dart';

/// Bottom sheet view mode
enum BottomSheetViewMode {
  list,
  map,
}

/// A draggable glassmorphic bottom sheet with list/map toggle
///
/// Features:
/// - Three snap positions: collapsed (120px), half (50%), full (95%)
/// - List/Map view toggle
/// - Smooth drag animations
/// - Glass effect
class MapBottomSheet extends ConsumerStatefulWidget {
  final List<ProviderEntity> providers;
  final ProviderEntity? selectedProvider;
  final Function(ProviderEntity) onProviderTap;
  final VoidCallback onViewModeToggle;

  const MapBottomSheet({
    super.key,
    required this.providers,
    this.selectedProvider,
    required this.onProviderTap,
    required this.onViewModeToggle,
  });

  @override
  ConsumerState<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends ConsumerState<MapBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Snap positions
  static const double _minHeight = 120;
  late double _maxHeight;
  late double _halfHeight;

  double _currentHeight = _minHeight;
  BottomSheetViewMode _viewMode = BottomSheetViewMode.list;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: _minHeight, end: _minHeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenHeight = MediaQuery.of(context).size.height;
    _maxHeight = screenHeight * 0.95;
    _halfHeight = screenHeight * 0.5;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateToHeight(double targetHeight) {
    _animation = Tween<double>(
      begin: _currentHeight,
      end: targetHeight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _controller.forward(from: 0).then((_) {
      setState(() => _currentHeight = targetHeight);
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentHeight = (_currentHeight - details.delta.dy)
          .clamp(_minHeight, _maxHeight);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    // Snap to nearest position
    final velocity = details.velocity.pixelsPerSecond.dy;

    double targetHeight;
    if (velocity.abs() > 500) {
      // Fast swipe
      targetHeight = velocity < 0 ? _maxHeight : _minHeight;
    } else {
      // Slow drag - snap to nearest
      final distances = [
        (_currentHeight - _minHeight).abs(),
        (_currentHeight - _halfHeight).abs(),
        (_currentHeight - _maxHeight).abs(),
      ];

      final minIndex = distances.indexOf(distances.reduce((a, b) => a < b ? a : b));
      targetHeight = [_minHeight, _halfHeight, _maxHeight][minIndex];
    }

    _animateToHeight(targetHeight);
  }

  void _toggleViewMode() {
    setState(() {
      _viewMode = _viewMode == BottomSheetViewMode.list
          ? BottomSheetViewMode.map
          : BottomSheetViewMode.list;
    });
    widget.onViewModeToggle();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final height = _controller.isAnimating
            ? _animation.value
            : _currentHeight;

        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: height,
          child: GestureDetector(
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(GlassTheme.radiusXLarge),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: GlassTheme.blurRadiusMedium,
                  sigmaY: GlassTheme.blurRadiusMedium,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(GlassTheme.opacityMedium),
                    border: Border.all(
                      color: Colors.white.withOpacity(GlassTheme.borderOpacity),
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(GlassTheme.radiusXLarge),
                    ),
                    boxShadow: GlassTheme.shadowVeryHigh,
                  ),
                  child: Column(
                    children: [
                      _buildHandle(),
                      _buildHeader(),
                      Expanded(
                        child: _viewMode == BottomSheetViewMode.list
                            ? _buildListView()
                            : _buildMapInstructions(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.textHint,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _viewMode == BottomSheetViewMode.list
                      ? 'Nearby Stations'
                      : 'Map View',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.providers.length} stations available',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // View Mode Toggle Button
          GlassCard(
            padding: const EdgeInsets.all(8),
            borderRadius: GlassTheme.radiusMedium,
            enableBlur: false,
            onTap: _toggleViewMode,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _viewMode == BottomSheetViewMode.list
                      ? Icons.map
                      : Icons.list,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  _viewMode == BottomSheetViewMode.list ? 'Map' : 'List',
                  style: AppTextStyles.buttonSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    if (widget.providers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ev_station_outlined,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'No stations found',
              style: AppTextStyles.h4.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: widget.providers.length,
      itemBuilder: (context, index) {
        final provider = widget.providers[index];
        return ProviderListItem(
          provider: provider,
          onTap: () => widget.onProviderTap(provider),
          isSelected: widget.selectedProvider?.id == provider.id,
          // TODO: Calculate actual distance
          distanceKm: (index + 1) * 0.5,
        );
      },
    );
  }

  Widget _buildMapInstructions() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: GlassTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.touch_app,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tap on markers',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a charging station on the map to view details and book',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GlassButton(
              label: 'Switch to List View',
              icon: Icons.list,
              variant: GlassButtonVariant.outlined,
              onPressed: _toggleViewMode,
            ),
          ],
        ),
      ),
    );
  }
}
