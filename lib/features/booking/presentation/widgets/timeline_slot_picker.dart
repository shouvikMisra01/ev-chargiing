import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/models/time_slot.dart';

/// Visual timeline slot picker with horizontal scrolling
///
/// Features:
/// - Date selector at top
/// - Scrollable time slots (6 AM - 10 PM)
/// - Color-coded availability
/// - Smooth animations
/// - Auto-scroll to current time
class TimelineSlotPicker extends StatefulWidget {
  final List<TimeSlot> availableSlots;
  final TimeSlot? selectedSlot;
  final Function(TimeSlot) onSlotSelected;
  final DateTime initialDate;

  const TimelineSlotPicker({
    super.key,
    required this.availableSlots,
    this.selectedSlot,
    required this.onSlotSelected,
    DateTime? initialDate,
  }) : initialDate = initialDate ?? const Duration(days: 0) as DateTime;

  @override
  State<TimelineSlotPicker> createState() => _TimelineSlotPickerState();
}

class _TimelineSlotPickerState extends State<TimelineSlotPicker> {
  late DateTime _selectedDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _scrollController = ScrollController();

    // Auto-scroll to current time after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    final now = DateTime.now();
    if (_selectedDate.day == now.day &&
        _selectedDate.month == now.month &&
        _selectedDate.year == now.year) {
      // Scroll to current hour (roughly)
      final currentHour = now.hour;
      if (currentHour >= 6 && currentHour <= 22) {
        final offset = (currentHour - 6) * 80.0; // Approximate slot height
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    }
  }

  List<TimeSlot> _getSlotsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return widget.availableSlots.where((slot) {
      return slot.startTime.isAfter(startOfDay) &&
          slot.startTime.isBefore(endOfDay);
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDateSelector(),
        const SizedBox(height: 16),
        _buildTimeline(),
      ],
    );
  }

  Widget _buildDateSelector() {
    final today = DateTime.now();
    final dates = List.generate(7, (index) {
      return today.add(Duration(days: index));
    });

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;
          final isToday = date.day == today.day &&
              date.month == today.month &&
              date.year == today.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: GlassCard(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: GlassTheme.radiusMedium,
              gradient: isSelected ? GlassTheme.primaryGradient : null,
              opacity: isSelected
                  ? GlassTheme.opacityHeavy
                  : GlassTheme.opacityLight,
              enableBlur: isSelected,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: AppTextStyles.h3.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isToday) ...[
                    const SizedBox(height: 4),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    final slotsForDate = _getSlotsForDate(_selectedDate);

    if (slotsForDate.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 64,
                color: AppColors.textHint,
              ),
              const SizedBox(height: 16),
              Text(
                'No slots available',
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please select another date',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: slotsForDate.length,
        itemBuilder: (context, index) {
          final slot = slotsForDate[index];
          return _buildTimeSlotCard(slot);
        },
      ),
    );
  }

  Widget _buildTimeSlotCard(TimeSlot slot) {
    final isSelected = widget.selectedSlot?.id == slot.id;
    final isPast = slot.endTime.isBefore(DateTime.now());
    final isFewLeft = !slot.isBooked && !isPast; // Mock: Check if few slots left

    Color statusColor;
    String statusText;
    if (isPast) {
      statusColor = AppColors.textHint;
      statusText = 'Past';
    } else if (slot.isBooked) {
      statusColor = AppColors.error;
      statusText = 'Booked';
    } else if (isFewLeft) {
      statusColor = AppColors.warning;
      statusText = 'Few left';
    } else {
      statusColor = AppColors.success;
      statusText = 'Available';
    }

    final canSelect = !slot.isBooked && !isPast;

    return GestureDetector(
      onTap: canSelect ? () => widget.onSlotSelected(slot) : null,
      child: GlassCard(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        borderRadius: GlassTheme.radiusLarge,
        gradient: isSelected ? GlassTheme.primaryGradient : null,
        opacity: isSelected
            ? GlassTheme.opacityHeavy
            : (canSelect ? GlassTheme.opacityMedium : GlassTheme.opacityLight),
        child: Row(
          children: [
            // Time indicator
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(width: 16),

            // Time range
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              statusText,
                              style: AppTextStyles.caption.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${slot.duration.inHours}h ${slot.duration.inMinutes.remainder(60)}m',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Selection indicator
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              )
            else if (canSelect)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border,
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
