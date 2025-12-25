import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TimeSlot {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;
  final bool isAvailable;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.isBooked = false,
    this.isAvailable = true,
  });
}

class AvailabilityManagementScreen extends ConsumerStatefulWidget {
  const AvailabilityManagementScreen({super.key});

  @override
  ConsumerState<AvailabilityManagementScreen> createState() =>
      _AvailabilityManagementScreenState();
}

class _AvailabilityManagementScreenState
    extends ConsumerState<AvailabilityManagementScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Mock slots data - would come from backend
  Map<DateTime, List<TimeSlot>> _slots = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _generateMockSlots();
  }

  void _generateMockSlots() {
    // Generate slots for next 30 days
    final today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      final date = DateTime(today.year, today.month, today.day + i);
      _slots[date] = _generateSlotsForDay(date);
    }
  }

  List<TimeSlot> _generateSlotsForDay(DateTime date) {
    final slots = <TimeSlot>[];
    // Generate 4-hour slots from 6 AM to 10 PM
    for (int hour = 6; hour < 22; hour += 4) {
      final startTime = DateTime(date.year, date.month, date.day, hour);
      final endTime = startTime.add(const Duration(hours: 4));

      // Randomly mark some slots as booked (for demo)
      final isBooked = date.isAfter(DateTime.now()) &&
          date.isBefore(DateTime.now().add(const Duration(days: 7))) &&
          hour == 14;

      slots.add(TimeSlot(
        id: 'slot_${date.day}_$hour',
        startTime: startTime,
        endTime: endTime,
        isBooked: isBooked,
        isAvailable: !isBooked,
      ));
    }
    return slots;
  }

  List<TimeSlot> _getSlotsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _slots[normalizedDay] ?? [];
  }

  bool _hasBookedSlots(DateTime day) {
    final slots = _getSlotsForDay(day);
    return slots.any((slot) => slot.isBooked);
  }

  bool _hasAvailableSlots(DateTime day) {
    final slots = _getSlotsForDay(day);
    return slots.any((slot) => slot.isAvailable && !slot.isBooked);
  }

  Future<void> _toggleSlotAvailability(TimeSlot slot) async {
    if (slot.isBooked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot modify a booked slot'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // TODO: Call backend API to toggle slot availability
    // await dio.put('/owner/availability/toggle', data: {'slotId': slot.id});

    setState(() {
      final day = DateTime(
        slot.startTime.year,
        slot.startTime.month,
        slot.startTime.day,
      );
      final daySlots = _slots[day];
      if (daySlots != null) {
        final index = daySlots.indexWhere((s) => s.id == slot.id);
        if (index != -1) {
          daySlots[index] = TimeSlot(
            id: slot.id,
            startTime: slot.startTime,
            endTime: slot.endTime,
            isBooked: slot.isBooked,
            isAvailable: !slot.isAvailable,
          );
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          slot.isAvailable
              ? 'Slot marked as unavailable'
              : 'Slot marked as available',
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  Future<void> _bulkUpdateDay(DateTime day, bool available) async {
    final slots = _getSlotsForDay(day);
    final bookedSlots = slots.where((s) => s.isBooked).length;

    if (bookedSlots > 0 && !available) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot mark day unavailable. $bookedSlots slot(s) are booked.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // TODO: Call backend API
    // await dio.put('/owner/availability/bulk', data: {
    //   'date': day.toIso8601String(),
    //   'available': available,
    // });

    setState(() {
      final normalizedDay = DateTime(day.year, day.month, day.day);
      _slots[normalizedDay] = slots.map((slot) {
        if (slot.isBooked) return slot;
        return TimeSlot(
          id: slot.id,
          startTime: slot.startTime,
          endTime: slot.endTime,
          isBooked: slot.isBooked,
          isAvailable: available,
        );
      }).toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(available
            ? 'All slots marked as available'
            : 'All slots marked as unavailable'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDaySlots = _selectedDay != null ? _getSlotsForDay(_selectedDay!) : [];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manage Availability'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar
          Container(
            color: Colors.white,
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 90)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() => _calendarFormat = format);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (_hasBookedSlots(date)) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  } else if (_hasAvailableSlots(date)) {
                    return Positioned(
                      bottom: 1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),

          // Legend
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(AppColors.success, 'Available'),
                _buildLegendItem(Colors.orange, 'Has Bookings'),
                _buildLegendItem(AppColors.error, 'Unavailable'),
              ],
            ),
          ),

          // Bulk Actions
          if (_selectedDay != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.background,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Selected: ${_formatDate(_selectedDay!)}',
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _bulkUpdateDay(_selectedDay!, true),
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: const Text('Open All'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.success,
                      side: const BorderSide(color: AppColors.success),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => _bulkUpdateDay(_selectedDay!, false),
                    icon: const Icon(Icons.block, size: 16),
                    label: const Text('Close All'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),

          // Time Slots List
          Expanded(
            child: selectedDaySlots.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 64,
                          color: AppColors.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No slots available for this day',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: selectedDaySlots.length,
                    itemBuilder: (context, index) {
                      final slot = selectedDaySlots[index];
                      return _buildSlotCard(slot);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddSlotDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Slot'),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildSlotCard(TimeSlot slot) {
    final isPast = slot.startTime.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          slot.isBooked
              ? Icons.event_busy
              : slot.isAvailable
                  ? Icons.event_available
                  : Icons.event_busy,
          color: slot.isBooked
              ? Colors.orange
              : slot.isAvailable
                  ? AppColors.success
                  : AppColors.error,
          size: 32,
        ),
        title: Text(
          '${_formatTime(slot.startTime)} - ${_formatTime(slot.endTime)}',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: isPast ? AppColors.textSecondary : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          slot.isBooked
              ? 'Booked'
              : slot.isAvailable
                  ? 'Available'
                  : 'Unavailable',
          style: AppTextStyles.caption.copyWith(
            color: slot.isBooked
                ? Colors.orange
                : slot.isAvailable
                    ? AppColors.success
                    : AppColors.error,
          ),
        ),
        trailing: Switch(
          value: slot.isAvailable,
          onChanged: isPast || slot.isBooked
              ? null
              : (value) => _toggleSlotAvailability(slot),
          activeColor: AppColors.success,
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Manage Availability'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHelpItem('📅', 'Select a date from the calendar'),
              _buildHelpItem('⏰', 'Toggle individual time slots on/off'),
              _buildHelpItem('🔵', 'Green dot = available slots'),
              _buildHelpItem('🟠', 'Orange dot = has bookings'),
              _buildHelpItem('🔴', 'Booked slots cannot be disabled'),
              _buildHelpItem('📦', 'Use "Open All" or "Close All" for bulk updates'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }

  void _showAddSlotDialog() {
    TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 12, minute: 0);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add Time Slot'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Start Time'),
                  trailing: Text(startTime.format(context)),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (time != null) {
                      setDialogState(() => startTime = time);
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Time'),
                  trailing: Text(endTime.format(context)),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (time != null) {
                      setDialogState(() => endTime = time);
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Add slot via API
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Slot added successfully'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }
}
