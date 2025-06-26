import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';

class ProviderSetupScreen extends StatefulWidget {
  const ProviderSetupScreen({super.key});

  @override
  State<ProviderSetupScreen> createState() => _ProviderSetupScreenState();
}

class _ProviderSetupScreenState extends State<ProviderSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  
  String _selectedPortType = 'Type 2';
  final List<String> _portTypes = ['Type 1', 'Type 2', 'CCS', 'CHAdeMO'];
  
  List<XFile> _equipmentImages = [];
  List<XFile> _parkingImages = [];
  
  Position? _currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadExistingData();
  }

  void _loadExistingData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.userModel;
    
    if (user?.providerDetails != null) {
      _addressController.text = user!.providerDetails!.address;
      _priceController.text = user.providerDetails!.pricePerHour.toString();
      _selectedPortType = user.providerDetails!.chargingPortType;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition();
      
      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      
      if (placemarks.isNotEmpty && _addressController.text.isEmpty) {
        final place = placemarks.first;
        _addressController.text = 
            '${place.street}, ${place.locality}, ${place.administrativeArea}';
      }
      
      setState(() {});
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _pickImages(bool isEquipment) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    
    setState(() {
      if (isEquipment) {
        _equipmentImages = images;
      } else {
        _parkingImages = images;
      }
    });
  }

  Future<void> _saveProviderDetails() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_equipmentImages.isEmpty || _parkingImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload both equipment and parking images'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location not available. Please try again.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.userModel!;

      // In a real app, you would upload images to Firebase Storage
      // For now, we'll use placeholder URLs
      final equipmentUrls = _equipmentImages.map((img) => 'placeholder_url').toList();
      final parkingUrls = _parkingImages.map((img) => 'placeholder_url').toList();

      final providerDetails = ProviderDetails(
        address: _addressController.text,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        equipmentImages: equipmentUrls,
        parkingImages: parkingUrls,
        chargingPortType: _selectedPortType,
        pricePerHour: double.parse(_priceController.text),
        isOnline: false,
        availableSlots: [],
      );

      final updatedUser = UserModel(
        id: user.id,
        email: user.email,
        phoneNumber: user.phoneNumber,
        name: user.name,
        role: user.role,
        isVerified: true, // In real app, this would be set after admin verification
        createdAt: user.createdAt,
        providerDetails: providerDetails,
      );

      final success = await authProvider.updateUserProfile(updatedUser);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Provider setup completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Station Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Station Address',
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter station address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedPortType,
                decoration: const InputDecoration(
                  labelText: 'Charging Port Type',
                  prefixIcon: Icon(Icons.electric_car),
                ),
                items: _portTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPortType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price per Hour (₹)',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price per hour';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Equipment Images',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload photos of your charging equipment',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(
                    _equipmentImages.isEmpty
                        ? 'Upload Equipment Photos'
                        : '${_equipmentImages.length} photos selected',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _pickImages(true),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Parking Images',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload photos showing parking availability',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(
                    _parkingImages.isEmpty
                        ? 'Upload Parking Photos'
                        : '${_parkingImages.length} photos selected',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _pickImages(false),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProviderDetails,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Provider Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}