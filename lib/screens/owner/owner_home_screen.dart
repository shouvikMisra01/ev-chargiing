import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/booking_provider.dart';
import '../../models/user_model.dart';
import 'provider_setup_screen.dart';
import 'availability_screen.dart';
import 'owner_bookings_screen.dart';
import '../../models/booking_model.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    
    if (authProvider.userModel != null) {
      await bookingProvider.loadProviderBookings(authProvider.userModel!.id);
    }
  }

  Future<void> _toggleOnlineStatus(bool isOnline) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    if (authProvider.userModel != null) {
      final success = await userProvider.updateProviderStatus(
        authProvider.userModel!.id,
        isOnline,
      );
      
      if (success) {
        // Update local user model
        final updatedUser = UserModel(
          id: authProvider.userModel!.id,
          email: authProvider.userModel!.email,
          phoneNumber: authProvider.userModel!.phoneNumber,
          name: authProvider.userModel!.name,
          role: authProvider.userModel!.role,
          isVerified: authProvider.userModel!.isVerified,
          createdAt: authProvider.userModel!.createdAt,
          providerDetails: authProvider.userModel!.providerDetails != null
              ? ProviderDetails(
                  address: authProvider.userModel!.providerDetails!.address,
                  latitude: authProvider.userModel!.providerDetails!.latitude,
                  longitude: authProvider.userModel!.providerDetails!.longitude,
                  equipmentImages: authProvider.userModel!.providerDetails!.equipmentImages,
                  parkingImages: authProvider.userModel!.providerDetails!.parkingImages,
                  chargingPortType: authProvider.userModel!.providerDetails!.chargingPortType,
                  pricePerHour: authProvider.userModel!.providerDetails!.pricePerHour,
                  isOnline: isOnline,
                  availableSlots: authProvider.userModel!.providerDetails!.availableSlots,
                )
              : null,
        );
        
        await authProvider.updateUserProfile(updatedUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OwnerBookingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.userModel;
          
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check if provider setup is complete
          if (!user.isVerified || user.providerDetails == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning,
                    size: 64,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Complete your provider setup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'You need to verify your charging station\nbefore accepting bookings',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProviderSetupScreen(),
                        ),
                      );
                    },
                    child: const Text('Setup Provider Profile'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Station Status',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              value: user.providerDetails!.isOnline,
                              onChanged: _toggleOnlineStatus,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.providerDetails!.isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: user.providerDetails!.isOnline
                                ? Colors.green
                                : Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Quick Stats
                Consumer<BookingProvider>(
                  builder: (context, bookingProvider, child) {
                    final todayBookings = bookingProvider.providerBookings
                        .where((booking) =>
                            booking.startTime.day == DateTime.now().day &&
                            booking.startTime.month == DateTime.now().month &&
                            booking.startTime.year == DateTime.now().year)
                        .length;
                    
                    final totalEarnings = bookingProvider.providerBookings
                        .where((booking) => booking.status == BookingStatus.completed)
                        .fold(0.0, (sum, booking) => sum + booking.totalAmount);

                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    '$todayBookings',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Text('Today\'s Bookings'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    '₹${totalEarnings.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const Text('Total Earnings'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                
                // Action Buttons
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    _buildActionCard(
                      icon: Icons.schedule,
                      title: 'Manage\nAvailability',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AvailabilityScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      icon: Icons.history,
                      title: 'View\nBookings',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OwnerBookingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      icon: Icons.settings,
                      title: 'Station\nSettings',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProviderSetupScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      icon: Icons.analytics,
                      title: 'View\nAnalytics',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Analytics feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}