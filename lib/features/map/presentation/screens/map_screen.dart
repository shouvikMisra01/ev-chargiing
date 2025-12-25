import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/animated_status_indicator.dart';
import '../providers/map_providers.dart';
import '../widgets/time_filter_sheet.dart';
import '../widgets/map_bottom_sheet.dart';
import '../../../owner/domain/entities/provider_entity.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  String _selectedPortFilter = 'All';
  bool _isListView = false;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(28.6139, 77.2090), // Delhi
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocationPermission();
      _updateMarkers();
    });
  }

  Future<void> _requestLocationPermission() async {
    await ref.read(userLocationProvider.notifier).refreshLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateMarkers();
  }

  void _updateMarkers() {
    final providersAsync = ref.read(nearbyProvidersProvider);
    var providers = providersAsync.value ?? [];
    final selectedProvider = ref.read(selectedProviderProvider);

    // Filter by port type if not "All"
    if (_selectedPortFilter != 'All') {
      providers = providers.where((provider) {
        return provider.portType.display == _selectedPortFilter;
      }).toList();
    }

    // Create markers for all providers (simple version for web)
    final markers = providers.map((provider) {
      final isSelected = provider.id == selectedProvider?.id;

      return Marker(
        markerId: MarkerId(provider.id),
        position: LatLng(
          provider.location.latitude,
          provider.location.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          isSelected
              ? BitmapDescriptor.hueBlue
              : provider.isOnline
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueRed,
        ),
        onTap: () => _onMarkerTapped(provider),
        infoWindow: InfoWindow(
          title: provider.ownerName,
          snippet: '₹${provider.pricePerHour.toStringAsFixed(0)}/hr • ${provider.portType.display}',
        ),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(markers);
    });
  }

  void _onMarkerTapped(ProviderEntity provider) {
    ref.read(selectedProviderProvider.notifier).selectProvider(provider);
    _updateMarkers();
  }

  void _showTimeFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TimeFilterSheet(),
    );
  }

  void _onViewModeToggle() {
    setState(() {
      _isListView = !_isListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = ref.watch(userLocationProvider);
    final selectedProvider = ref.watch(selectedProviderProvider);
    final providersAsync = ref.watch(nearbyProvidersProvider);
    final timeFilter = ref.watch(timeFilterStateProvider);

    final providers = providersAsync.value ?? [];

    // Update markers when providers change
    ref.listen(nearbyProvidersProvider, (_, __) => _updateMarkers());
    ref.listen(selectedProviderProvider, (_, __) => _updateMarkers());

    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Glass Search Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderRadius: GlassTheme.radiusMedium,
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Search for charging stations...',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GlassCard(
                        padding: const EdgeInsets.all(8),
                        borderRadius: GlassTheme.radiusSmall,
                        enableBlur: false,
                        gradient: timeFilter != null ? GlassTheme.primaryGradient : null,
                        onTap: _showTimeFilterSheet,
                        child: Icon(
                          Icons.access_time,
                          color: timeFilter != null ? AppColors.primary : AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Glass Filter Chips
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Type 2'),
                  const SizedBox(width: 8),
                  _buildFilterChip('CCS'),
                  const SizedBox(width: 8),
                  _buildFilterChip('CHAdeMO'),
                ],
              ),
            ),
          ),

          // Bottom Sheet with List/Map Toggle
          MapBottomSheet(
            providers: providers,
            selectedProvider: selectedProvider,
            onProviderTap: (provider) {
              _onMarkerTapped(provider);
              // Animate camera to provider
              if (_mapController != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(
                      provider.location.latitude,
                      provider.location.longitude,
                    ),
                    15,
                  ),
                );
              }
            },
            onViewModeToggle: _onViewModeToggle,
          ),

          // My Location Button (Glass Style)
          Positioned(
            right: 16,
            bottom: 200,
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              borderRadius: 28,
              onTap: () async {
                final location = await userLocation.whenOrNull(
                  data: (pos) => pos,
                );

                if (location != null && _mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(location.latitude, location.longitude),
                      14,
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.my_location,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildGlassBottomNav(),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedPortFilter == label;

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 20,
      gradient: isSelected ? GlassTheme.primaryGradient : null,
      opacity: isSelected ? GlassTheme.opacityHeavy : GlassTheme.opacityMedium,
      enableBlur: isSelected,
      onTap: () {
        setState(() => _selectedPortFilter = label);
        _updateMarkers();
      },
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildGlassBottomNav() {
    return GlassCard(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      enableBlur: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.map,
                label: 'Map',
                isSelected: true,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.history,
                label: 'Bookings',
                isSelected: false,
                onTap: () => context.push(AppRoutes.bookingHistory),
              ),
              _NavItem(
                icon: Icons.wallet,
                label: 'Wallet',
                isSelected: false,
                onTap: () => context.push(AppRoutes.wallet),
              ),
              _NavItem(
                icon: Icons.person,
                label: 'Profile',
                isSelected: false,
                onTap: () => context.push(AppRoutes.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedStatusIndicator(
            status: isSelected ? IndicatorStatus.available : IndicatorStatus.offline,
            size: 4,
            showLabel: false,
          ),
          const SizedBox(height: 4),
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: 28,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
