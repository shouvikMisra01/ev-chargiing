import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/glass_button.dart';
import '../../../../shared/widgets/animated_counter.dart';
import '../../../../shared/models/time_slot.dart';
import '../../../map/presentation/providers/map_providers.dart';
import '../providers/booking_providers.dart';
import '../widgets/timeline_slot_picker.dart';
import '../widgets/station_photo_gallery.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String providerId;

  const BookingScreen({
    super.key,
    required this.providerId,
  });

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  TimeSlot? _selectedSlot;
  bool _isLoading = false;

  Future<void> _confirmBooking() async {
    if (_selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a time slot'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final provider = await ref.read(nearbyProvidersProvider.notifier).getProviderById(widget.providerId);

    if (provider == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Provider not found'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final error = await ref.read(userBookingsProvider.notifier).createBooking(
          providerId: provider.id,
          providerName: provider.ownerName,
          providerLocation: provider.location,
          portType: provider.portType,
          startTime: _selectedSlot!.startTime,
          endTime: _selectedSlot!.endTime,
          pricePerHour: provider.pricePerHour,
        );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Booking created successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Navigate back
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(nearbyProvidersProvider.notifier).getProviderById(widget.providerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Book Charging Slot'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final provider = snapshot.data;
        if (provider == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Book Charging Slot'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Provider not found',
                    style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          );
        }

        final availableSlots = provider.availableSlots.where((slot) => slot.isAvailable).toList();
        final totalAmount = _selectedSlot != null
            ? (_selectedSlot!.duration.inMinutes / 60 * provider.pricePerHour)
            : 0.0;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Book Charging Slot'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo Gallery
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: StationPhotoGallery(
                  imageUrls: [
                    ...provider.equipmentImages,
                    ...provider.parkingImages,
                  ],
                  height: 200,
                ),
              ),

              // Provider Info Glass Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: GlassTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.ev_station,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.ownerName,
                              style: AppTextStyles.h4.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
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
                                    provider.location.address ?? 'Address not available',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Pricing Info Glass Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _InfoItem(
                          icon: Icons.currency_rupee,
                          label: 'Price',
                          value: '₹${provider.pricePerHour.toStringAsFixed(0)}/hr',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.border.withOpacity(0),
                              AppColors.border,
                              AppColors.border.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: _InfoItem(
                          icon: Icons.electric_bolt,
                          label: 'Port Type',
                          value: provider.portType.display,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Timeline Slot Picker
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Time Slot',
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: TimelineSlotPicker(
                            availableSlots: availableSlots,
                            selectedSlot: _selectedSlot,
                            onSlotSelected: (slot) {
                              setState(() => _selectedSlot = slot);
                            },
                            initialDate: DateTime.now(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
          bottomNavigationBar: GlassCard(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.zero,
            borderRadius: 0,
            enableBlur: true,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedSlot != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        AnimatedCurrency(
                          amount: totalAmount,
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  GlassButton(
                    label: 'Confirm Booking',
                    icon: Icons.check_circle,
                    variant: GlassButtonVariant.primary,
                    onPressed: _isLoading || _selectedSlot == null ? null : _confirmBooking,
                    isLoading: _isLoading,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: GlassTheme.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
