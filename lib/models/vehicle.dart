class Vehicle {
  final String id;
  final String vehicleNumber;
  final String location;
  final String status;
  final double latitude;
  final double longitude;
  final double speed;
  final String lastUpdated;

  Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.location,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.lastUpdated,
  });
}