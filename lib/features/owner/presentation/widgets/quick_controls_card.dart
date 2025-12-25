import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/glass_button.dart';
import '../../../../shared/widgets/animated_status_indicator.dart';

/// Quick management controls for owner dashboard
///
/// Features:
/// - Availability toggle (Online/Offline)
/// - Quick price adjustment slider
/// - Real-time status updates
/// - Haptic feedback
class QuickControlsCard extends StatefulWidget {
  final bool isOnline;
  final double currentPrice;
  final Function(bool) onAvailabilityChanged;
  final Function(double) onPriceChanged;

  const QuickControlsCard({
    super.key,
    required this.isOnline,
    required this.currentPrice,
    required this.onAvailabilityChanged,
    required this.onPriceChanged,
  });

  @override
  State<QuickControlsCard> createState() => _QuickControlsCardState();
}

class _QuickControlsCardState extends State<QuickControlsCard> {
  late bool _isOnline;
  late double _tempPrice;
  bool _showPriceInput = false;

  @override
  void initState() {
    super.initState();
    _isOnline = widget.isOnline;
    _tempPrice = widget.currentPrice;
  }

  void _toggleAvailability() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isOnline = !_isOnline;
    });
    widget.onAvailabilityChanged(_isOnline);
  }

  void _applyPriceChange() {
    HapticFeedback.lightImpact();
    widget.onPriceChanged(_tempPrice);
    setState(() {
      _showPriceInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassPrimaryCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bolt,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Controls',
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Manage your station instantly',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Availability Toggle
          _buildAvailabilityToggle(),

          const SizedBox(height: 16),

          // Price Control
          _buildPriceControl(),
        ],
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: GlassTheme.radiusMedium,
      gradient: _isOnline
          ? GlassTheme.successGradient
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.textHint.withOpacity(0.3),
                AppColors.textHint.withOpacity(0.1),
              ],
            ),
      child: Row(
        children: [
          // Status Indicator
          AnimatedStatusIndicator(
            status: _isOnline ? IndicatorStatus.available : IndicatorStatus.offline,
            size: 12,
          ),

          const SizedBox(width: 12),

          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Station Status',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isOnline ? 'Online' : 'Offline',
                  style: AppTextStyles.h4.copyWith(
                    color: _isOnline ? AppColors.success : AppColors.textHint,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Toggle Switch
          GestureDetector(
            onTap: _toggleAvailability,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 32,
              decoration: BoxDecoration(
                color: _isOnline ? AppColors.success : AppColors.textHint,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (_isOnline ? AppColors.success : AppColors.textHint)
                        .withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                alignment: _isOnline ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isOnline ? Icons.check : Icons.close,
                    size: 16,
                    color: _isOnline ? AppColors.success : AppColors.textHint,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceControl() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: GlassTheme.radiusMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Price per Hour',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (!_showPriceInput)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showPriceInput = true;
                      _tempPrice = widget.currentPrice;
                    });
                  },
                  child: Text(
                    'Adjust',
                    style: AppTextStyles.buttonSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),

          if (!_showPriceInput) ...[
            const SizedBox(height: 8),
            Text(
              '₹${widget.currentPrice.toStringAsFixed(0)}',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],

          if (_showPriceInput) ...[
            const SizedBox(height: 16),

            // Slider
            Row(
              children: [
                Text(
                  '₹20',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.primary.withOpacity(0.2),
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withOpacity(0.2),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: _tempPrice,
                      min: 20,
                      max: 200,
                      divisions: 36, // ₹5 increments
                      onChanged: (value) {
                        setState(() {
                          _tempPrice = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  '₹200',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            // Current Value
            Center(
              child: Text(
                '₹${_tempPrice.toStringAsFixed(0)}/hr',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Apply/Cancel Buttons
            Row(
              children: [
                Expanded(
                  child: GlassButton(
                    label: 'Cancel',
                    variant: GlassButtonVariant.outlined,
                    onPressed: () {
                      setState(() {
                        _showPriceInput = false;
                        _tempPrice = widget.currentPrice;
                      });
                    },
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassButton(
                    label: 'Apply',
                    variant: GlassButtonVariant.primary,
                    onPressed: _applyPriceChange,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
