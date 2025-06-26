import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  List<TimeSlot> _availableSlots = [];

  @override
  void initState() {
    super.initState();
    _loadExistingSlots();
  }

  void _loadExistingSlots() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.userModel;
    
    if (user?.providerDetails != null) {
      setState(() {
        _availableSlots = List.from(user!.providerDetails!.availableSlots);
      });
    }
  }

  Future<void> _addTimeSlot() async {
    DateTime? startTime;
    DateTime? endTime;

    // Pick start time
    await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 30)),
      onConfirm: (date) {
        startTime = date;
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );

    if (startTime == null) return;

    // Pick end time
    await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: startTime!.add(const Duration(hours: 1)),
      maxTime: startTime!.add(const Duration(hours: 12)),
      onConfirm: (date) {
        endTime = date;
      },
      currentTime: startTime!.add(const Duration(hours: 2)),
      locale: LocaleType.en,
    );

    if (endTime == null) return;

    // Check for conflicts
    bool hasConflict = _availableSlots.any((slot) {
      return (startTime!.isBefore(slot.endTime) && endTime!.isAfter(slot.startTime));
    });

    if (hasConflict) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Time slot conflicts with existing availability'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _availableSlots.add(TimeSlot(
        startTime: startTime!,
        endTime: endTime!,
      ));
    });
  }

  Future<void> _saveAvailability() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    if (authProvider.userModel != null) {
      final success = await userProvider.updateProviderAvailability(
        authProvider.userModel!.id,
        _availableSlots,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Availability updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update availability'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeSlot(int index) {
    setState(() {
      _availableSlots.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Availability'),
        actions: [
          TextButton(
            onPressed: _saveAvailability,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set Your Availability',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add time slots when your charging station is available for booking.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _addTimeSlot,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Time Slot'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _availableSlots.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No availability set',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add time slots to start receiving bookings',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _availableSlots.length,
                    itemBuilder: (context, index) {
                      final slot = _availableSlots[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: slot.isBooked
                                ? Colors.red[100]
                                : Colors.green[100],
                            child: Icon(
                              slot.isBooked ? Icons.lock : Icons.schedule,
                              color: slot.isBooked ? Colors.red : Colors.green,
                            ),
                          ),
                          title: Text(
                            DateFormat('MMM dd, yyyy').format(slot.startTime),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${DateFormat('hh:mm a').format(slot.startTime)} - ${DateFormat('hh:mm a').format(slot.endTime)}',
                          ),
                          trailing: slot.isBooked
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Booked',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeSlot(index),
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}