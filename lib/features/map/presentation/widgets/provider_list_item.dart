import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/animated_status_indicator.dart';
import '../../../owner/domain/entities/provider_entity.dart';

/// A glassmorphic list item showing provider/station details
///
/// Used in the map bottom sheet list view
class ProviderListItem extends StatelessWidget {
  final ProviderEntity provider;
  final VoidCallback onTap;
  final bool isSelected;
  final double? distanceKm;

  const ProviderListItem({
    super.key,
    required this.provider,
    required this.onTap,
    this.isSelected = false,
    this.distanceKm,
  });

  IndicatorStatus get _status {
    if (!provider.isOnline) return IndicatorStatus.offline;
    if (!provider.canAcceptBookings) return IndicatorStatus.busy;
    return IndicatorStatus.available;
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      borderRadius: GlassTheme.radiusLarge,
      opacity: isSelected ? GlassTheme.opacityHeavy : GlassTheme.opacityMedium,
      gradient: isSelected ? GlassTheme.primaryGradient : null,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station Image or Placeholder
            _buildStationImage(),

            const SizedBox(width: 12),

            // Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Owner Name & Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          provider.ownerName,
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedStatusIndicator(
                        status: _status,
                        size: 8,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${provider.location.address}, ${provider.location.city}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (distanceKm != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '${distanceKm!.toStringAsFixed(1)} km',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Port Type, Price, Rating
                  Row(
                    children: [
                      // Port Type Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          provider.portType.display,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Price
                      Text(
                        '₹${provider.pricePerHour.toStringAsFixed(0)}/hr',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Spacer(),

                      // Rating
                      if (provider.rating != null) ...[
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          provider.rating!.toStringAsFixed(1),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (provider.totalRatings != null)
                          Text(
                            ' (${provider.totalRatings})',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Chevron
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationImage() {
    final imageUrl = provider.equipmentImages.isNotEmpty
        ? provider.equipmentImages.first
        : null;

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: GlassTheme.primaryGradient,
      ),
      child: const Icon(
        Icons.ev_station,
        size: 32,
        color: AppColors.primary,
      ),
    );
  }
}
