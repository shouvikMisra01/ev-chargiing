import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import '../../providers/booking_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';

class BookingScreen extends StatefulWidget {
  final UserModel provider;

  const BookingScreen({super.key, required this.provider});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;
  TimeSlot? _selectedSlot;

  double get _totalAmount {
    if (_selectedStartTime == null || _selectedEndTime == null) return 0.0;
    
    final duration = _selectedEndTime!.difference(_selectedStartTime!).inHours;
    return duration * widget.provider.providerDetails!.pricePerHour;
  }

  Future<void> _selectTimeSlot() async {
    final availableSlots = widget.provider.providerDetails!.availableSlots
        .where((slot) => !slot.isBooked)
        .toList();

    if (availableSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No available time slots'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Time Slots',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...availableSlots.map((slot) {
              return ListTile(
                title: Text(
                  '${DateFormat('MMM dd, yyyy').format(slot.startTime)}',
                ),
                subtitle: Text(
                  '${DateFormat('hh:mm a').format(slot.startTime)} - ${DateFormat('hh:mm a').format(slot.endTime)}',
                ),
                trailing: Text(
                  '₹${((slot.endTime.difference(slot.startTime).inHours) * widget.provider.providerDetails!.pricePerHour).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedSlot = slot;
                    _selectedStartTime = slot.startTime;
                    _selectedEndTime = slot.endTime;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> _bookSlot() async {
    if (_selectedStartTime == null || _selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time slot'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    final success = await bookingProvider.createBooking(
      userId: authProvider.userModel!.id,
      providerId: widget.provider.id,
      startTime: _selectedStartTime!,
      endTime: _selectedEndTime!,
      totalAmount: _totalAmount,
      providerAddress: widget.provider.providerDetails!.address,
      providerLatitude: widget.provider.providerDetails!.latitude,
      providerLongitude: widget.provider.providerDetails!.longitude,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking confirmed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Charging Slot'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.provider.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.provider.providerDetails!.address,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.electric_car, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Port: ${widget.provider.providerDetails!.chargingPortType}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          '₹${widget.provider.providerDetails!.pricePerHour}/hour',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Time Slot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                  _selectedSlot != null
                      ? '${DateFormat('MMM dd, yyyy').format(_selectedStartTime!)} - ${DateFormat('hh:mm a').format(_selectedStartTime!)} to ${DateFormat('hh:mm a').format(_selectedEndTime!)}'
                      : 'Select time slot',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _selectTimeSlot,
              ),
            ),
            if (_selectedStartTime != null && _selectedEndTime != null) ...[
              const SizedBox(height: 24),
              Card(
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Duration:'),
                          Text(
                            '${_selectedEndTime!.difference(_selectedStartTime!).inHours} hours',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Rate:'),
                          Text(
                            '₹${widget.provider.providerDetails!.pricePerHour}/hour',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${_totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<BookingProvider>(
          builder: (context, bookingProvider, child) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedStartTime != null && !bookingProvider.isLoading)
                    ? _bookSlot
                    : null,
                child: bookingProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Confirm Booking'),
              ),
            );
          },
        ),
      ),
    );
  }
}