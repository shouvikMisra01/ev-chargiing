import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../booking/domain/entities/booking_entity.dart';

/// Swipeable booking approval card for quick owner actions
///
/// Features:
/// - Swipe right to approve (green)
/// - Swipe left to reject (red)
/// - One-tap approval
/// - Auto-dismiss animation
class BookingApprovalCard extends StatefulWidget {
  final BookingEntity booking;
  final Function(String bookingId) onApprove;
  final Function(String bookingId, String reason) onReject;

  const BookingApprovalCard({
    super.key,
    required this.booking,
    required this.onApprove,
    required this.onReject,
  });

  @override
  State<BookingApprovalCard> createState() => _BookingApprovalCardState();
}

class _BookingApprovalCardState extends State<BookingApprovalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragExtent = 0;
  bool _isDismissed = false;

  static const double _dismissThreshold = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isDismissed) return;

    setState(() {
      _dragExtent += details.primaryDelta ?? 0;
      _dragExtent = _dragExtent.clamp(-200.0, 200.0);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isDismissed) return;

    if (_dragExtent.abs() >= _dismissThreshold) {
      // Dismiss
      setState(() => _isDismissed = true);

      _controller.forward().then((_) {
        if (_dragExtent > 0) {
          // Approved (swipe right)
          widget.onApprove(widget.booking.id);
        } else {
          // Rejected (swipe left)
          _showRejectDialog();
        }
      });
    } else {
      // Return to center
      setState(() => _dragExtent = 0);
    }
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => _RejectDialog(
        onReject: (reason) {
          widget.onReject(widget.booking.id, reason);
        },
      ),
    );
  }

  Color _getBackgroundColor() {
    if (_dragExtent > _dismissThreshold) {
      return AppColors.success;
    } else if (_dragExtent < -_dismissThreshold) {
      return AppColors.error;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        transform: Matrix4.translationValues(_dragExtent, 0, 0),
        child: Stack(
          children: [
            // Background actions
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: _getBackgroundColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(GlassTheme.radiusLarge),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Reject (left)
                    if (_dragExtent < 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: AppColors.error,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Reject',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const Spacer(),

                    // Approve (right)
                    if (_dragExtent > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: AppColors.success,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Approve',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Card content
            GlassCard(
              padding: const EdgeInsets.all(16),
              borderRadius: GlassTheme.radiusLarge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: GlassTheme.warningGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.pending_actions,
                          color: AppColors.warning,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending Approval',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              'Booking #${widget.booking.id.substring(0, 8)}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // User info
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.booking.userId, // Would be user name in real app
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Time slot
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${DateFormat('MMM d, h:mm a').format(widget.booking.startTime)} - ${DateFormat('h:mm a').format(widget.booking.endTime)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Amount
                  Row(
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      Text(
                        widget.booking.totalAmount.toStringAsFixed(2),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '← Swipe to approve or reject →',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textHint,
                          fontStyle: FontStyle.italic,
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
    );
  }
}

/// Dialog for rejecting booking with reason
class _RejectDialog extends StatefulWidget {
  final Function(String reason) onReject;

  const _RejectDialog({required this.onReject});

  @override
  State<_RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<_RejectDialog> {
  String _selectedReason = '';
  final List<String> _reasons = [
    'Not available at requested time',
    'Maintenance scheduled',
    'Station temporarily offline',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        borderRadius: GlassTheme.radiusLarge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reject Booking',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please select a reason for rejecting this booking',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ..._reasons.map((reason) => _buildReasonOption(reason)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedReason.isNotEmpty
                        ? () {
                            widget.onReject(_selectedReason);
                            Navigator.of(context).pop();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    final isSelected = _selectedReason == reason;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReason = reason;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.error.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.error : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.error : AppColors.textHint,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                reason,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isSelected ? AppColors.error : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
