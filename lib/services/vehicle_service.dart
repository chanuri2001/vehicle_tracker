import 'package:vehicle_tracker/models/vehicle.dart';

class VehicleService {
  // Mock data service
  Future<List<Vehicle>> getVehicles() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return [
      Vehicle(
        id: '1',
        vehicleNumber: 'KA1234',
        location: 'Downtown, San Francisco',
        status: 'Active',
        latitude: 37.7749,
        longitude: -122.4194,
        speed: 45.0,
        lastUpdated: '10 min ago',
      ),
      Vehicle(
        id: '2',
        vehicleNumber: 'KA5678',
        location: 'Mission District, San Francisco',
        status: 'Idle',
        latitude: 37.7599,
        longitude: -122.4148,
        speed: 0.0,
        lastUpdated: '5 min ago',
      ),
      Vehicle(
        id: '3',
        vehicleNumber: 'KA9012',
        location: 'SoMa, San Francisco',
        status: 'Maintenance',
        latitude: 37.7785,
        longitude: -122.3950,
        speed: 0.0,
        lastUpdated: '1 hour ago',
      ),
      Vehicle(
        id: '4',
        vehicleNumber: 'KA3456',
        location: 'Nob Hill, San Francisco',
        status: 'Active',
        latitude: 37.7930,
        longitude: -122.4161,
        speed: 30.0,
        lastUpdated: '2 min ago',
      ),
      Vehicle(
        id: '5',
        vehicleNumber: 'KA7890',
        location: 'Marina District, San Francisco',
        status: 'Offline',
        latitude: 37.8037,
        longitude: -122.4368,
        speed: 0.0,
        lastUpdated: '3 hours ago',
      ),
    ];
  }
}
